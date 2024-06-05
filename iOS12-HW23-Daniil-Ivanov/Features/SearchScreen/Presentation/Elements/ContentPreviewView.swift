//
//  ContentPreviewView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 04.06.2024.
//

import SwiftUI

struct ContentPreviewView: View {
    let content: [AnyAppContent]
    let onContentTapped: AnyAppContentClosure

    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(content) { contentItem in
                ContentPreviewItemView(
                    contentItem: contentItem,
                    onContentTapped: onContentTapped
                )
                Divider()
            }
        }
    }
}

private struct ContentPreviewItemView: View {
    let contentItem: AnyAppContent
    let onContentTapped: AnyAppContentClosure
    private static let dotSymbol = "·"

    var body: some View {

        HStack(spacing: 16) {
            Button {
                onContentTapped(contentItem)
            } label: {
                Image(contentItem.image)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                VStack(alignment: .leading, spacing: 3) {
                    let subtitle = """
                    \(contentItem.type) \(Self.dotSymbol) \(contentItem.subtitle ?? "")
                    """

                    Text(contentItem.title)
                    Text(subtitle)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
            }
            .foregroundStyle(Color(.label))

            if contentItem.isDownloaded {
                Button(action: {}, label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .foregroundStyle(.gray)
                })
            }
            Button(action: {}, label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(Color(.label))
                    .padding(.trailing, 8)
            })
        }
        .padding(.vertical, 16)
    }
}
