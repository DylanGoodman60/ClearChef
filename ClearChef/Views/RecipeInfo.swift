//
//  RecipeInfo.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI
import PhotosUI

enum Flavor: String, CaseIterable, Identifiable {
    case chocolate, vanilla, strawberry
    var id: Self { self }
}

struct RecipeInfo: View {
    var recipe: Recipe // recipe as param

    // Let's put 'binding' for editable items here, with ContentView containing source of truth 'state'
    @Environment(\.editMode) private var editMode
    @State private var description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    @State private var prepTime = Date.now

    @State private var selectedFlavor: Flavor = .chocolate
    
    var body: some View {
        Form {
            if editMode?.wrappedValue.isEditing == true {
                PhotosSelector()
                TextField("Description", text: $description, axis: .vertical)
                Picker("Flavor", selection: $selectedFlavor) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized)
                    }
                }
            } else {
                Image(systemName: "birthday.cake")
                    .resizable()
                Text(description)
                HStack {
                    Text("Category")
                    Spacer()
                    Text(selectedFlavor.rawValue)
                }
            }
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
        .navigationTitle(recipe.id)
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

func nothing() {}

