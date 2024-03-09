//
//  Ingredient.swift
//  ClearChef
//
//  Created by Taylor Newman on 2024-03-09.
//

import Foundation
import SwiftUI

struct Ingredient: Identifiable, Hashable {
    var id = UUID()
    var title: String
}

struct Direction: Identifiable, Hashable {
    var id = UUID()
    var title: String
}

