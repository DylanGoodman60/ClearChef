//
//  IngredientLinkPage.swift
//  ClearChef
//
//  Created by Taylor Newman on 2024-03-09.
//

import Foundation
import SwiftUI

struct IngredientLinkPage: View {
    var ingredients: [Ingredient]
    @Binding var directionMapList: [UUID: [UUID]]
    let direction: UUID
    
    
    var body: some View {
        List(ingredients) { ingredient in
            HStack{
                if var directionMapListUnwrapped = directionMapList[direction]{
                    if directionMapListUnwrapped.contains(ingredient.id){
                        Image(systemName: "checkmark.circle.fill").foregroundStyle(.blue)
                    } else {
                        Image(systemName: "circle").foregroundStyle(.blue)
                    }
                    Button(ingredient.title) {
                        if let index = directionMapListUnwrapped.firstIndex(of: ingredient.id){
                            directionMapListUnwrapped.remove(at: index)
                        } else {
                            directionMapListUnwrapped.append(ingredient.id)
                        }
                        directionMapList[direction] = directionMapListUnwrapped

                    }
                }


            }

        }
    }
}
