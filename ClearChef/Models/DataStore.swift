//
//  RecipeStore.swift
//  ClearChef
//
//  Created by Taylor Newman on 2024-04-03.
//

import SwiftUI

class DataStore: ObservableObject {
    @Published var recipes: [Recipe] = [
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
    
    @Published var categories: [Category] = [
        Category(title: "Breakfast"),
        Category(title: "Stir Fry")
    ]
    
    func deleteRecipe(id: UUID) -> Void {
        recipes.removeAll { recipe in
            recipe.id == id
        }
    }
    
    func deleteCategory(id: UUID) -> Void {
        categories.removeAll { category in
            category.id == id
        }
    }
    
/// We can use this later to get recipes from storage
//    init(isDarkMode: Bool) {
//        self._recipes = Published(initialValue: functionCall())
//    }
}
