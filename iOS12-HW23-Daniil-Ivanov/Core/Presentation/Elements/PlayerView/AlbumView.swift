//
//  AlbumView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 13.05.2024.
//

import SwiftUI

struct AlbumView: View {
    let width: CGFloat
    let height: CGFloat
    let image: ImageResource?

    var body: some View {
        Group {
            let shadowColor = Color.gray.opacity(0.5)

            if let image {
                // Album image
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: shadowColor, radius: 4, x: 0, y: 3)
            } else {
                // Placeholder image
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.systemGray5))
                        .frame(width: width, height: height)
                        .shadow(color: shadowColor, radius: 4, x: 0, y: 3)
                    Image(systemName: "music.note")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width * 0.6, height: height * 0.6)
                        .foregroundStyle(Color(UIColor.systemGray3))
                }
            }
        }
    }
}
