//
//  RatingView.swift
//  ClearChef
//
//  Created by Taylor Newman on 2024-04-03.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var maximumRating = 5

    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage
        } else {
            onImage
        }
    }
    
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    withAnimation {
                        rating = number
                    }
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }.buttonStyle(.plain)
    }
}


struct RatingLabel: View {
    var rating: Int
    var maxRating = 5
    
    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage
        } else {
            onImage
        }
    }
    
    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundStyle(number > rating ? offColor : onColor)
            }
        }.buttonStyle(.plain)
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
