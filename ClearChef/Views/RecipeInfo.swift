//
//  RecipeInfo.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI
import PhotosUI


struct RecipeInfo: View {
    @Binding var recipe: Recipe // recipe as param

    // Let's put 'binding' for editable items here, with ContentView containing source of truth 'state'
    @Environment(\.editMode) private var editMode

    func durationString(selection: [String]) -> Text {
        var a: String = selection[1]
        if selection[0] != "0 h" {
            a = selection[0] + " " + a
        }
        return Text(a)
    }
    
    var previewForm: some View {
        Form {
            recipe.image.frame(height: 200)
            VStack{
                Text("Description")
                Text(recipe.description)
            }
            
            HStack {
                Text("Prep Time")
                Spacer()
                durationString(selection: recipe.prepTime)
            }
            HStack {
                Text("Cook Time")
                Spacer()
                durationString(selection: recipe.cookTime)
            }
            Section("Ingredients") {
                ForEach(recipe.ingredients) { ingredient in
                    Text(ingredient.title)
                }
            }
            
            Section("Directions") {
                ForEach(recipe.directions) { direction in
                    Text(direction.title)
                }
            }
            
        }
    }
    
    var choice: some View {
        if editMode?.wrappedValue.isEditing == true {
            AnyView(AddEditRecipe(recipe: $recipe))
        } else {
            AnyView(previewForm)
        }
    }

    var body: some View {
        choice.navigationTitle(recipe.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .bottomBar) {
                NavigationLink {
                    RecipeViewer()
                } label: {
                    Image(systemName: "play.rectangle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                }
            }
        }
    }
}



