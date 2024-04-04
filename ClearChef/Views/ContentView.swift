//
//  ContentView.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var recipeStore: DataStore
    
    @State var infoForId = UUID()
    
    
    func addRecipe() -> Void {
        let recipe = Recipe(title: "", category: recipeStore.categories[0])
        recipeStore.recipes.append(recipe)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipeStore.categories) { category in
                    Section(category.title) {
                        ForEach(0..<recipeStore.recipes.count, id: \.self) { recipe_index in
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
