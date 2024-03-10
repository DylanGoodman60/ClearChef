//
//  ContentView.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var recipes: [Recipe] = [
        .init(title: "Pad Thai", category: Category(title: "Breakfast")),
        .init(title: "Oatmeal", category: Category(title: "Breakfast"))
    ]
    
    @State private var categories: [Category] = [
        Category(title: "Breakfast"),
        Category(title: "Stir Fry")
    ]
    
    
    func addRecipe() -> Void {
        var recipe = Recipe(title: "", category: Category(title: "Breakfast"))
        recipes.append(recipe)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Favourites") {
                    ForEach(0..<recipes.count, id: \.self) { recipe_index in
                        NavigationLink(value: recipe_index) {
                            RecipeRow(recipe: recipes[recipe_index])
                        }
                    }
                }
            }
            .navigationDestination(for: Int.self) { recipe_index in
                RecipeInfo(recipe: $recipes[recipe_index])
            }
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
                        AddEditRecipe(recipe: $recipes[recipes.count - 1])
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

#Preview {
    ContentView()
}
