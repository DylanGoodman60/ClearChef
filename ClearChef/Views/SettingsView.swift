//
//  SettingsView.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

struct TextSettings {
    var fontFamily: String
    var fontSize: CGFloat
    var fontColor: Color
    var isEditingFontSize: Bool
}

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var textSettings = TextSettings(fontFamily: "Verdana", fontSize: 48.0, fontColor: .white, isEditingFontSize: false)
    
    var body: some View {
        let selectedFont = Font(UIFont(name: textSettings.fontFamily, size: textSettings.fontSize) ?? UIFont.systemFont(ofSize: textSettings.fontSize))
            Form {
                HStack {
                    Spacer()
                    Text("Aa")
                        .foregroundColor((textSettings.fontColor == .white) ? (colorScheme == .dark ? .white : .black) : textSettings.fontColor)
                        .font(selectedFont)
                    Spacer()
                }
                .frame(minHeight: 124)
                Picker("Font", selection: $textSettings.fontFamily) {
                    Text("DIN").tag("DIN-Bold")
                    Text("Futura").tag("Futura-Medium")
                    Text("Bodini").tag("BodoniSvtyTwoITCTT-Bold")
                }
                .pickerStyle(.segmented)
                HStack {
                    Text("\(textSettings.fontSize)")
                    Slider(
                        value: $textSettings.fontSize,
                        in: 48...96,
                        step: 1
                    ) {
                        Text("Font Size")
                    } onEditingChanged: { editing in
                        textSettings.isEditingFontSize = editing
                    }
                }
                ColorPicker("Font Color", selection: $textSettings.fontColor)
            }
            .navigationTitle("Settings")
    }
}

