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
        VStack {
            Form {
                Section {
                    HStack{
                        Text("Description")
                        Spacer()
                        Text(recipe.description)
                    }
                } header: {
                    recipe.image.resizable().scaledToFill().frame(width: UIScreen.main.bounds.width).padding(.bottom, 20).clipShape(RoundedRectangle(cornerRadius: 10))
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
    }

    var body: some View {
        HStack {
            if editMode?.wrappedValue.isEditing == true {
                AddEditRecipe(recipe: $recipe)
            } else {
                previewForm
            }
        }.navigationTitle(recipe.title).toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .bottomBar) {
                NavigationLink {
                    RecipeViewer(recipe: recipe)
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

#Preview {
    ContentView().environmentObject(DataStore())
}


