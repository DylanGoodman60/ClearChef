//
//  SettingsView.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI
import UIKit
import AVFoundation

let apiKey = "87d650be0f3b4d11b3d99e8802886898"

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore
    @Environment(\.colorScheme) var colorScheme
    @State var isEditingFontSize: Bool = false

    var body: some View {
        let selectedFont = Font(UIFont(name: settings.fontFamily, size: settings.fontSize) ?? UIFont.systemFont(ofSize: settings.fontSize))

            Form {
                Section("Display") {
                    HStack {
                        Spacer()
                        Text("Aa")
                            .foregroundColor((settings.fontColor == .white) ? (colorScheme == .dark ? .white : .black) : settings.fontColor)
                            .font(selectedFont)
                        Spacer()
                    }
                    .frame(minHeight: 124)
                    Picker("Font", selection: $settings.fontFamily) {
                        Text("DIN").tag("DIN-Bold")
                        Text("Futura").tag("Futura-Medium")
                        Text("Bodini").tag("BodoniSvtyTwoITCTT-Bold")
                    }
                    .pickerStyle(.segmented)
                    HStack {
                        Text("\(Int(settings.fontSize))")
                        Slider(
                            value: $settings.fontSize,
                            in: 42...76,
                            step: 1
                        ) {
                            Text("Font Size")
                        } onEditingChanged: { editing in
                            isEditingFontSize = editing
                        }
                    }
                    ColorPicker("Font Color", selection: $settings.fontColor)
                }
                    Section("Text-to-speech") {
                        Toggle(isOn: $settings.isSpeechOn) {
                            Text("Text-to-speech")
                                .onChange(of: settings.isSpeechOn) { value in
                                    if (value == true) {
                                        speak(text: "Text to speech enabled", rate: 0.6)
                                    }
                                }
                        }
                        Button("Test Voice") {
                            

                        }
                    }
            }
            .navigationTitle("Settings")
    }
}

func speak(text: String, rate: Float) {
    let utterance = AVSpeechUtterance(string: text)
    utterance.rate = rate
    utterance.volume = 1
    
    let voice = AVSpeechSynthesisVoice(language: "en-US")
    utterance.voice = voice
    
    let synthesizer = AVSpeechSynthesizer()
    synthesizer.speak(utterance)
}
