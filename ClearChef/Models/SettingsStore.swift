//
//  SettingsStore.swift
//  ClearChef
//
//  Created by MercRothwell on 4/4/24.
//

import SwiftUI

class SettingsStore: ObservableObject {
    @Published var fontFamily: String = "Futura-Medium"
    @Published var fontSize: CGFloat = 48.0
    @Published var fontColor: Color = .white
    @Published var isSpeechOn: Bool = true
}
