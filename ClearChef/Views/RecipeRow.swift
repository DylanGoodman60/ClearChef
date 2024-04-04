//
//  SwiftUIView.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe
    @Binding var infoOnId: UUID?
    @EnvironmentObject private var dataStore: DataStore

    var body: some View {
        VStack {
            HStack {
                recipe.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .foregroundStyle(.tint).padding(.trailing)
                Text(recipe.title)
                Spacer()
                Button {
                    infoOnId = recipe.id
                } label: {
                    Image(systemName: "info.circle").foregroundStyle(.blue)
                }
            }
            if(infoOnId != nil && infoOnId == recipe.id){
                Divider()
                HStack {
                    VStack (alignment: .leading) {
                        Text("Cook Time: " + recipe.cookTime[0] +
                             " " +
                             recipe.cookTime[1])
                            Text("Difficulty")
                            RatingLabel(rating: recipe.difficulty)
                    }.frame(alignment: .leading)
                    Button(action: {
                        //TODO: remove recipe
                        dataStore.deleteRecipe(id: recipe.id)
                    }, label: {
                        ZStack {
                            Color.red.clipShape(RoundedRectangle(cornerRadius: 10.0)).frame(width: 90, height: 50)
                                
                            HStack {
                                Image(systemName: "trash")
                                Text("Delete")
                            }.foregroundStyle(.white)
                        }.padding(.leading, 40)
                    })
                }
            }

        }
        
    }
}


#Preview {
    ContentView().environmentObject(DataStore())
}
