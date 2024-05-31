//
//  AppContentListView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

enum AppContentDisplayMode {
    case big
    case small
}

struct AppContentListView<Content: AppContent>: View {
    let height: CGFloat
    let contentWidth: CGFloat
    let content: [Content]
    let spacing: Double?
    let leadingPadding: Double?
    let mode: AppContentDisplayMode

    init(
        height: CGFloat,
        contentWidth: CGFloat,
        content: [Content],
        spacing: Double? = nil,
        leadingPadding: Double? = nil,
        mode: AppContentDisplayMode = .big
    ) {
        self.height = height
        self.contentWidth = contentWidth
        self.content = content
        self.spacing = spacing
        self.leadingPadding = leadingPadding
        self.mode = mode
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            let spacing = spacing ?? leadingPadding ?? 8
            let contentWidth = calculateContentWidth()
            LazyHStack(spacing: spacing) {
                ForEach(content) { content in
                    viewForContent(content)
                        .frame(width: contentWidth)
                }

                // Trailing padding
                Color.clear.frame(maxWidth: 0)
            }
            .padding(.leading, leadingPadding ?? 0)
        }
    }

    @ViewBuilder
    private func viewForContent(_ content: Content) -> some View {
        switch mode {
        case .big:
            AppContentView(
                content: content,
                imageHeight: height * 0.67
            )
        case .small:
            AppContentSmallView(content: content)
        }
    }

    private func calculateContentWidth() -> Double {
        switch mode {
        case .big:
            self.contentWidth > 0 ? self.contentWidth : 450
        case .small:
            self.contentWidth > 0 ? self.contentWidth : 270
        }
    }
}

#Preview {
    AppContentListView(height: 300, contentWidth: 300, content: RadioShow.examples, spacing: 10, leadingPadding: 10)
}
