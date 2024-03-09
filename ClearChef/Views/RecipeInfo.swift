//
//  RecipeInfo.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI
import PhotosUI


struct RecipeInfo: View {
    var recipe: Recipe // recipe as param

    // Let's put 'binding' for editable items here, with ContentView containing source of truth 'state'
    @Environment(\.editMode) private var editMode
    @State private var description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    @State private var prepTime = Date.now


    var previewForm: some View {
        Form {
            Image(systemName: "birthday.cake").frame(height: 200)
            TextField("Description", text: $description, axis: .vertical)
            HStack {
                Text("Prep Time")
                Spacer()

            }
            HStack {
                Text("Cook Time")
                Spacer()
                Text("1 Hour and 30 Minutes")
            }
            Section("Ingredients") {
                Text("1 cup oil")
                Text("3 tbsp peanuts")
            }
        }
    }
    
    var choice: some View {
        if editMode?.wrappedValue.isEditing == true {
            AnyView(AddEditRecipe(recipe: recipe))
        } else {
            AnyView(previewForm)
        }
    }

    var body: some View {
        choice.navigationTitle(recipe.id)
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



