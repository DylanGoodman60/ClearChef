//
//  ContentView.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    let recipes: [Recipe] = [
        .init(id: "Pad Thai"),
        .init(id: "Oatmeal")
    ]

    var body: some View {
        NavigationStack {
            List {
                Section("Favourites") {
                    ForEach(recipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeRow(recipe: recipe)
                        }
                    }
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeInfo(recipe: recipe)
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
                        AddRecipe()
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.blue)
                    }
                }
            }
        }

    }
}

#Preview {
    ContentView()
}
