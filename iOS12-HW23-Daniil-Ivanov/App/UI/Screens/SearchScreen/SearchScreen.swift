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

    private enum SearchState {
        case categories
        case results
        case historyEmpty
        case history
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
    private var searchState: SearchState = .categories

    @State 
    private var scope: SearchScope = .appleMusic

    @State
    private var allContentList: [AnyAppContent] = []

    @State
    private var isClearSearchHistoryDialogPresented = false

    @Environment(PlayerParameters.self)
    private var playerParameters

    let categories = SearchCategory.examples

    var body: some View {
        ScrollView(showsIndicators: false) {
            makeSearchView()
        }
        .padding(.horizontal, 16)
        .searchable(
            text: $searchText,
            isPresented: $isSearchInProgress,
            placement: .navigationBarDrawer,
            prompt: "Ваша Медиатека"
        )
        .searchScopes($scope, activation: .onSearchPresentation) {
            ForEach(SearchScope.allCases, id: \.self) { scope in
                Text(scope.rawValue).tag(scope)
            }
        }
        .onAppear {
            loadContent()
        }
        .onChange(of: isSearchInProgress) { _, _ in
            updateSearchState()
            searchInProgressHandler()
        }
        .onChange(of: searchText) { _, _ in
            updateSearchState()
            prepareSearchText()
            updateSearchResults()
        }
        .onChange(of: searchHistory) { _, _ in
            updateSearchState()
        }
        .onChange(of: isClearSearchHistoryDialogPresented) { _, _ in
            updateSearchState()
        }
        .navigationTitle("Поиск")
        .navigationDestination(for: SearchPath.self) { path in
            switch path {
            case .category(let category):
                CategoryScreen(category: category)
            }
        }
        .confirmationDialog(
            "",
            isPresented: $isClearSearchHistoryDialogPresented,
            titleVisibility: .hidden
        ) {
            Button(role: .destructive) {
                clearSearchHistory()
                isClearSearchHistoryDialogPresented = false
            } label: {
                Text("Очистить недавние поиски")
            }
        }
    }

    @ViewBuilder
    private func makeSearchView() -> some View {
        switch searchState {
        case .categories:
            SearchCategoriesView(categories: categories)
                .opacity(searchCategoriesOpacity)
        case .results, .history, .historyEmpty:
            makeSearchResultsOrHistoryView()
        }
    }

    @ViewBuilder
    private func makeSearchResultsOrHistoryView() -> some View {
        switch searchState {
        case .results:
            SearchResultsView(
                searchResults: searchResults,
                searchText: searchText,
                onContentSearchResultTapped: onContentSearchResultTapped(content:),
                onTextSearchResultTapped: onTextSearchResultTapped(title:)
            )
        case .history:
            SearchHistoryView(
                searchHistory: Array(searchHistory),
                onClearButtonTapped: onSearchHistoryClearButtonTapped
            )
        case .historyEmpty, .categories:
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

    private func updateSearchState() {
        guard isSearchInProgress || isClearSearchHistoryDialogPresented else {
            searchState = .categories
            return
        }

        if searchText.isEmpty {
            searchState = searchHistory.isEmpty ? .historyEmpty : .history
        } else {
            searchState = .results
        }
    }

    private func searchInProgressHandler() {
        playerParameters.isHidden = isSearchInProgress
        withAnimation(.easeIn(duration: 1).delay(0.1)) {
            searchCategoriesOpacity = isSearchInProgress ? 0 : 1
        }
    }

    private func prepareSearchText() {
        searchText = searchText.lowercased()
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

    private func onContentSearchResultTapped(content: AnyAppContent) {
        searchHistory.append(content)
    }

    private func onTextSearchResultTapped(title: String) {
        searchText = title
    }

    private func onSearchHistoryClearButtonTapped() {
        isClearSearchHistoryDialogPresented = true
    }

    private func clearSearchHistory() {
        searchHistory.removeAll()
    }
}

// MARK: - DEBUG

#Preview {
    MainFlow()
}

