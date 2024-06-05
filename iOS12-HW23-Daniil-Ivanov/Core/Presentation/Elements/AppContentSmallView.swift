//
//  AppContentSmallview.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct AppContentSmallView<Content: AppContent> : View {
    let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Image(content.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            Text(content.title)
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(1)
            Text(content.subtitle ?? "")
                .font(.caption2)
                .lineLimit(1)
                .foregroundStyle(.gray)
        }
    }
}
