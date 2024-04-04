//
//  ClearChefApp.swift
//  ClearChef
//
//  Created by MercRothwell on 3/6/24.
//

import SwiftUI

@main
struct ClearChefApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(DataStore())
        }
    }
}
