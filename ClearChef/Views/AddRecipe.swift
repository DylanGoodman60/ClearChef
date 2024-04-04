//
//  AddRecipe.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

struct AddRecipe: View {
    @Binding var recipeList: [Recipe]
    @State private var recipe: Recipe
    
    init(recipeList: Binding<[Recipe]>) {
        self._recipeList = recipeList
        self._recipe = State(initialValue: Recipe(title: ""))
        
        self.recipeList.append(self.recipe)
    }
    
    var body: some View {
        AddEditRecipe(recipe: $recipe)
    }
}
