//
//  File.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import Foundation
import SwiftUI

struct Recipe: Identifiable, Hashable {
    var id: String
    var image: Image {
        Image(systemName: "globe")
    }
}
