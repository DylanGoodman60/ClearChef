//
//  ContentView.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var recipes: [Recipe] = [
        .init(title: "Pad Thai",
              description: "Easy Pad Thai Recipe",
              category: Category(title: "Breakfast"),
              cookTime: ["1 h", "10 m"],
              ingredients: [
                Ingredient(title: "400 g Rice Noodles"),
                Ingredient(title: "1/2 tbsp Soy Sauce"),
                Ingredient(title: "3 Lime Wedges")
              ],
              directions: [
                Direction(title: "Cook Rice Noodles"),
                Direction(title: "Add soy sauce"),
                Direction(title: "Eat")
              ],
              image: Image("padThai")),
        .init(title: "OatMeal",
              description: "Easy Oatmeal Recipe",
              category: Category(title: "Breakfast"),
              cookTime: ["0 h", "10 m"],
              ingredients: [
                Ingredient(title: "1/2 cup rolled oats"),
                Ingredient(title: "1/2 tbsp suager"),
                Ingredient(title: "Blueberries")
              ],
              directions: [
                Direction(title: "Cook Oats"),
                Direction(title: "Add berries"),
                Direction(title: "Eat")
              ],
              image: Image("oatmeal")),
    ]
    
    @State private var categories: [Category] = [
        Category(title: "Breakfast"),
        Category(title: "Stir Fry")
    ]
    
    
    func addRecipe() -> Void {
        let recipe = Recipe(title: "", category: categories[0])
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
