//
//  AppContentListView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct AppContentListView<Content: AppContent & Identifiable>: View {
    let height: CGFloat
    let contentWidth: CGFloat
    let content: [Content]
    let spacing: Double?
    let leadingPadding: Double?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            let spacing = spacing ?? leadingPadding ?? 8
            LazyHStack(spacing: spacing) {
                ForEach(content) { content in
                    AppContentView(
                        content: content,
                        imageHeight: height * 0.67
                    )
                    .frame(maxWidth: contentWidth)
                }

                // Trailing padding
                Color.clear.frame(maxWidth: 0)
            }
            .padding(.leading, leadingPadding ?? 0)
        }
    }
}

#Preview {
    AppContentListView(height: 300, contentWidth: 300, content: RadioShow.examples, spacing: 10, leadingPadding: 10)
}
