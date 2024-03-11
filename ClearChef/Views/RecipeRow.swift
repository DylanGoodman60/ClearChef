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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(recipe.title)
            Spacer()
        }
        
    }
}
