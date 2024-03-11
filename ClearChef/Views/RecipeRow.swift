//
//  SwiftUIView.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe

    var body: some View {
        HStack {
            recipe.image
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .foregroundStyle(.tint).padding(.trailing)
            Text(recipe.title)
            Spacer()
        }
        
    }
}
