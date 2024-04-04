//
//  File.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import Foundation
import SwiftUI

struct Recipe: Identifiable {
    var id = UUID()
    var title: String = ""
    var description: String = ""
    var category: Category
    var difficulty: Int = 3
    var prepTime: [String] = ["0 h", "20 m"]
    var cookTime: [String] = ["0 h", "20 m"]
    var ingredients: [Ingredient] = []
    var directions: [Direction] = []
    var directionsMap: [UUID: [UUID]] = [:]
    
    
    var image: Image = Image(systemName: "globe")
}
