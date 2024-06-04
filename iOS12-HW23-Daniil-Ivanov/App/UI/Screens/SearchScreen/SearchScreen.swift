//
//  SearchScreen.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI
import OrderedCollections

typealias AnyAppContentClosure = (AnyAppContent) -> Void
typealias StringClosure = (String) -> Void

enum SearchPath: Hashable {
    case category(SearchCategory)
}

struct SearchScreen: View {

    private enum SearchScope: String, CaseIterable {
        case appleMusic = "Apple Music"
        case media = "Ваша Медиатека"
    }
    }

    @State
    private var searchText = ""

    @State
    private var isSearchInProgress = false

    @State
    private var searchHistory: OrderedSet<AnyAppContent> = []

    @State
    private var searchResults: [AnyAppContent] = []

    @State
    private var searchCategoriesOpacity = 1.0

    @State
    private var searchResultsOpacity: Double = 0.0

    @State 
    private var scope: SearchScope = .appleMusic

    @State
    private var allContentList: [AnyAppContent] = []

    @Environment(PlayerParameters.self)
    private var playerParameters

    let categories = SearchCategory.examples

    var body: some View {
        ScrollView(showsIndicators: false) {
            makeSearchView()
        }
        .navigationTitle("Поиск")
        .padding(.horizontal, 16)
        .navigationDestination(for: SearchPath.self) { path in
            switch path {
            case .category(let category):
                CategoryScreen(category: category)
            }
        }
        .searchable(
            text: $searchText,
            isPresented: $isSearchInProgress,
            placement: .navigationBarDrawer,
            prompt: "Ваша Медиатека"
        )
        .searchScopes($scope, activation: .onSearchPresentation) {
        }
        .onChange(of: isSearchInProgress) { _, newValue in
            playerParameters.isHidden = newValue
            withAnimation(.easeIn(duration: 1).delay(0.1)) {
                searchCategoriesOpacity = isSearchInProgress ? 0 : 1
            }
            withAnimation() {
                searchResultsOpacity = isSearchInProgress ? 1 : 0
            ForEach(SearchScope.allCases, id: \.self) { scope in
                Text(scope.rawValue).tag(scope)
            }
        }
        .onChange(of: searchText) { _, _ in
            searchText = searchText.lowercased()
            updateSearchResults()
        }
        .onAppear {
            loadContent()
        }

    }

    @ViewBuilder
    private func makeSearchView() -> some View {
        if isSearchInProgress {
            makeSearchResultsOrHistoryView()
                .opacity(searchResultsOpacity)
        } else {
            SearchCategoriesView(categories: categories)
                .opacity(searchCategoriesOpacity)
        }
    }

    @ViewBuilder
    private func makeSearchResultsOrHistoryView() -> some View {
        let isSeachHistoryShown = isSearchInProgress
            && searchText.isEmpty && !searchHistory.isEmpty

        if isSeachHistoryShown {
            SearchHistoryView(
                searchHistory: searchHistory,
                onClearButtonTapped: {
                    searchHistory.removeAll()
                }
            )
        } else if isSearchInProgress {
            SearchResultsView(
                searchResults: searchResults,
                searchText: searchText,
                onContentSearchResultTapped: { content in
                    searchHistory.append(content)
                },
                onTextSearchResultTapped: { title in
                    searchText = title
                }
            )
        } else {
            EmptyView()
        }
    }

    private func loadContent() {
        let allSongs = (Playlist.examples
            .flatMap { $0.songs }
        + Album.examples
            .flatMap { $0.songs }
        + [Song.example])
            .map { AnyAppContent($0) }

        let allPlaylists = Playlist.examples.map { AnyAppContent($0) }

        let allAlbums = Album.examples.map { AnyAppContent($0) }

        allContentList = allPlaylists + allAlbums + allSongs
    }

    private func updateSearchResults() {
        if searchText.isEmpty {
            searchResults.removeAll()
        } else {
            performSearch()
        }
    }

    private func performSearch() {
        searchResults = allContentList.filter { $0.title.lowercased().hasPrefix(searchText.lowercased()) }
    }
}


private struct SearchCategoriesView: View {
    let categories: [SearchCategory]

    @Environment(PlayerParameters.self)
    private var playerParameters

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        Text("Поиск по категориям")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title3)
            .fontWeight(.bold)

        LazyVGrid(columns: columns) {
            ForEach(categories) { category in
                SearchCategoryItemView(category: category)
            }
        }

        Color.clear.frame(height: playerParameters.height)
    }
}

private struct SearchCategoryItemView: View {
    let category: SearchCategory

    var body: some View {
        NavigationLink(value: SearchPath.category(category)) {
            ZStack(alignment: .leading) {
                Image(category.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
                Text(category.name)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(10)
            }
        }
    }
}

private struct SearchResultsView: View {
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
        VStack(alignment: .leading,spacing: 0, content: {
            ForEach(0..<itemsCount, id: \.self) { index in
                let data = searchResults[index]
                TextSearchResultsItemView(
                    title: data.title.lowercased(),
                    searchText: searchText, 
                    onItemTapped: onSearchResultTapped
                )
                Divider()
            }
        })
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

private struct ContentPreviewView: View {
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
                Image(systemName: "arrow.down.circle.fill")
                    .foregroundStyle(.gray)
            }
            Image(systemName: "ellipsis")
                .padding(.trailing, 8)
        }
        .padding(.vertical, 16)
    }
}

private struct SearchHistoryView: View {
    let searchHistory: [AnyAppContent]
    let onClearButtonTapped: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Недавние поиски")
                Spacer()
                Button("Очистить", action: onClearButtonTapped)
            }
            .font(.callout)
            .fontWeight(.semibold)
            Divider()
                .padding(.top, 8)
            ContentPreviewView(
                content: searchHistory,
                // Open content
                onContentTapped: { _ in }
            )
        }
        .padding(.top, 16)
    }
}

// MARK: - DEBUG

#Preview {
    MainFlow()
}

#Preview {
    SearchScreen()
}

struct SearchResultsViewContainer : View {
    @State
    private var searchResults = Album.examples.flatMap { $0.songs }.map { AnyAppContent($0) }
    @State
    private var searchText: String = ""

    var body: some View {
        SearchResultsView(
            searchResults: searchResults,
            searchText: searchText,
            onContentSearchResultTapped: { _ in }, 
            onTextSearchResultTapped: { _ in }
        )
    }
}

#Preview {
    SearchResultsViewContainer()
}

