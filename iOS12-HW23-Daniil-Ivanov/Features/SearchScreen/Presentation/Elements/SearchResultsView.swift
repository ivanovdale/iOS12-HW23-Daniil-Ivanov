//
//  SearchResultsView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 04.06.2024.
//

import SwiftUI

struct SearchResultsView: View {
    let searchResults: [AnyAppContent]
    let searchText: String
    let onContentSearchResultTapped: AnyAppContentClosure
    let onTextSearchResultTapped: StringClosure

    var body: some View {
        LazyVStack(spacing: 0) {
            TextSearchResultsView(
                searchResults: searchResults,
                searchText: searchText,
                onSearchResultTapped: onTextSearchResultTapped
            )
            ContentPreviewView(
                content: searchResults,
                onContentTapped: onContentSearchResultTapped
            )
        }
    }
}

private struct TextSearchResultsView: View {
    let searchResults: [AnyAppContent]
    let searchText: String
    let onSearchResultTapped: StringClosure

    var body: some View {
        let itemsCount = searchResults.count > 3 ? 3 : searchResults.count
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<itemsCount, id: \.self) { index in
                let data = searchResults[index]
                TextSearchResultsItemView(
                    title: data.title.lowercased(),
                    searchText: searchText,
                    onItemTapped: onSearchResultTapped
                )
                Divider()
            }
        }
    }
}

private struct TextSearchResultsItemView: View {
    let title: String
    let searchText: String
    let onItemTapped: StringClosure

    var body: some View {
        Button(action: {
            onItemTapped(title)
        }, label: {
            HStack(spacing: 7) {
                Image(systemName: "magnifyingglass")
                HighlightedText(text: title, highlight: searchText)
            }
            .padding(.vertical, 16)
        })
        .foregroundStyle(Color(.label))
    }
}

private struct HighlightedText: View {
    let text: String
    let highlight: String

    var body: some View {
        let attributedString = NSMutableAttributedString(string: text)
        if !highlight.isEmpty {
            let range = (text as NSString).range(
                of: highlight,
                options: .caseInsensitive
            )
            attributedString.addAttribute(
                .font,
                value: UIFont.boldSystemFont(ofSize: 16),
                range: range
            )
        }

        return Text(AttributedString(attributedString))
    }
}


struct SearchResultsViewContainer : View {
    @State
    private var searchResults: [AnyAppContent] = {
        let songs = Album.examples.flatMap { $0.songs }
        return songs.map { AnyAppContent($0) }
    }()

    @State
    private var searchText: String = ""

    var body: some View {
        ScrollView {
            SearchResultsView(
                searchResults: searchResults,
                searchText: searchText,
                onContentSearchResultTapped: { _ in },
                onTextSearchResultTapped: { _ in }
            )
        }
    }
}

#Preview {
    SearchResultsViewContainer()
}
