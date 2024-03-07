//
//  RecipeInfo.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

struct RecipeInfo: View {
    var recipe: Recipe
    var body: some View {
        Image(systemName: "cup.and.saucer")
        Text(recipe.id)
        NavigationLink {
            RecipeViewer()
        } label: {
            Image(systemName: "play.rectangle")
                .resizable()
                .frame(width: 80, height: 80)
        }
    }
}
