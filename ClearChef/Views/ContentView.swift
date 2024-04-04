//
//  ContentView.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var recipeStore: DataStore
    
    @State var infoForId: UUID?
    
    
    func addRecipe() -> Void {
        let recipe = Recipe(title: "", category: recipeStore.categories[0])
        recipeStore.recipes.append(recipe)
    }
    
    func getRecipesForCategory(categoryName: String) -> [Int] {
        //TODO: Allow category to be nil
        let indicies = recipeStore.recipes.indices.filter { item in
            recipeStore.recipes[item].category == categoryName
        }
        return indicies
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipeStore.categories, id: \.self) { category in
                    let catRecipes = getRecipesForCategory(categoryName: category)
                    if catRecipes.count > 0 {
                        Section(category) {
                            ForEach(catRecipes, id: \.self) { recipe_index in
                                NavigationLink(value: recipe_index) {
                                    HStack {
                                        RecipeRow(recipe: recipeStore.recipes[recipe_index],  infoOnId: $infoForId)
                                    }
                                }
                            }
                        }
                    }
                }
                let unassignedCat = getRecipesForCategory(categoryName: "")
                if unassignedCat.count > 0 {
                    Section("Unassigned") {
                        ForEach(unassignedCat, id: \.self) { recipe_index in
                            NavigationLink(value: recipe_index) {
                                HStack {
                                    RecipeRow(recipe: recipeStore.recipes[recipe_index],  infoOnId: $infoForId)
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Int.self) { recipe_index in
                RecipeInfo(recipe: $recipeStore.recipes[recipe_index])
            }
            .buttonStyle(PlainButtonStyle())
            .navigationTitle("Clear Chef")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.blue)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddEditRecipe(recipe: $recipeStore.recipes[recipeStore.recipes.count - 1])
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.blue)
                    }.simultaneousGesture(TapGesture().onEnded {
                        addRecipe()
                    })
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataStore())

        ContentView()
            .previewInterfaceOrientation(.landscapeLeft).environmentObject(DataStore())
    }
}
