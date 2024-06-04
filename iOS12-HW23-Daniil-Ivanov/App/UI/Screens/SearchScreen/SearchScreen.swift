//
//  SearchScreen.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

enum SearchPath: Hashable {
    case category(SearchCategory)
}

struct SearchScreen: View {

    private enum SearchScope {
        case appleMusic
        case media
    }

    @State
    private var searchText = ""

    @State
    private var isSearchInProgress = false


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
            Text("Apple Music")
                .tag(SearchScope.appleMusic)
            Text("Ваша Медиатека")
                .tag(SearchScope.media)
        }
        .onChange(of: isSearchInProgress) { _, newValue in
            playerParameters.isHidden = newValue
            withAnimation(.easeIn(duration: 1).delay(0.1)) {
                searchCategoriesOpacity = isSearchInProgress ? 0 : 1
            }
            withAnimation() {
                searchResultsOpacity = isSearchInProgress ? 1 : 0
            }
        }
        .onAppear {
            loadContent()
        }

    }

    @ViewBuilder
    private func makeSearchView() -> some View {
        if isSearchInProgress {
            SearchResultsView(
                searchResults: $searchResults,
                searchText: $searchText
            )
            .opacity(searchResultsOpacity)
        } else {
            SearchCategoriesView(categories: categories)
                .opacity(searchCategoriesOpacity)
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
    @Binding
    var searchResults: [AnyAppContent]

    @Binding
    var searchText: String

    var body: some View {
        LazyVStack(spacing: 0) {
            TextSearchResultsView(
                searchResults: $searchResults,
                searchText: $searchText
            )
            ContentPreviewView(content: $searchResults)
        }

    }
}

private struct TextSearchResultsView: View {
    @Binding
    var searchResults: [AnyAppContent]

    @Binding
    var searchText: String

    var body: some View {
        let itemsCount = searchResults.count > 3 ? 3 : searchResults.count
        VStack(alignment: .leading,spacing: 0, content: {
            ForEach(0..<itemsCount, id: \.self) { index in
                let data = searchResults[index]
                TextSearchResultsItemView(
                    title: data.title.lowercased(),
                    searchText: $searchText
                )
                Divider()
            }
        })
    }
}

private struct TextSearchResultsItemView: View {
    let title: String

    @Binding
    var searchText: String

    var body: some View {
        HStack(spacing: 7) {
            Image(systemName: "magnifyingglass")
        }
        .padding(.vertical, 16)
    }
}
        }

    }
}

private struct ContentPreviewView: View {
    @Binding
    var content: [AnyAppContent]

    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(content) { contentItem in
                ContentPreviewItemView(contentItem: contentItem)
                Divider()
            }
        }
    }
}

private struct ContentPreviewItemView: View {
    let contentItem: AnyAppContent
    private static let dotSymbol = "·"

    var body: some View {

        HStack(spacing: 16) {
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
#Preview {
    SearchScreen()
}

#Preview {
    MainFlow()
}

