//
//  AppContentView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct AppContentView: View {
    let title: String
    let shortSummary: String?
    let tag: String
    let image: ImageResource
    let imageHeight: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text(tag)
                .font(.subheadline)
                .foregroundStyle(.gray)

            Text(title)
                .font(.title2)

            if let shortSummary {
                Text(shortSummary)
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            } else {
                Spacer()
                    .frame(height: 41)
            }

            Image(image)
                .resizable()
                .scaledToFill()
                .frame(height: imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}

#Preview {
    AppContentView(title: "123", shortSummary: "123", tag: "123", image: .cover1, imageHeight: 300)
}

#Preview {
    RadioScreen()
}
