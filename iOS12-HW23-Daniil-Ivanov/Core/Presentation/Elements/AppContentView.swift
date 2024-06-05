//
//  AppContentView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct AppContentView<Content: AppContent>: View {
    let content: Content
    let imageHeight: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text(content.secondaryTitle)
                .font(.subheadline)
                .foregroundStyle(.gray)

            Text(content.title)
                .font(.title2)
                .lineLimit(1)

            if let subtitle = content.subtitle {
                Text(subtitle)
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            } else {
                Spacer()
                    .frame(height: 41)
            }

            ZStack(alignment: .bottom) {
                Image(content.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: imageHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                if let description = content.description {
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                }

            }
        }
    }
}

#Preview {
    AppContentView(content: RadioShow.examples.first!, imageHeight: 300)
}
