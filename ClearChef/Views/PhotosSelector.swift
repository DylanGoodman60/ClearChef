//
//  PhotosSelector.swift
//  ClearChef
//
//  Created by MercRothwell on 3/7/24.
//

import SwiftUI
import PhotosUI


struct PhotosSelector: View {
    @State var selectedItems: PhotosPickerItem?


    var body: some View {
        PhotosPicker(selection: $selectedItems,
                     matching: .images) {
            Text("Select Multiple Photos")
        }
    }
}
