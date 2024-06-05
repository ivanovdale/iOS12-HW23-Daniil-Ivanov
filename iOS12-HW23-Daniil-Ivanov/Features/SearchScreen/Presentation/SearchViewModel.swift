//
//  SearchViewModel.swift
//  AppleMusic
//
//  Created by Daniil (work) on 05.06.2024.
//

import SwiftUI
import OrderedCollections

typealias AnyAppContentClosure = (AnyAppContent) -> Void
typealias StringClosure = (String) -> Void

@Observable
final class SearchViewModel {
    enum SearchState {
        case categories
        case results
        case historyEmpty
        case history
    }

    enum SearchScope: String, CaseIterable {
        case appleMusic = "Apple Music"
        case media = "Ваша Медиатека"
    }

    var searchText = ""
    var scope: SearchScope = .appleMusic
    var isSearchInProgress = false
    var isClearSearchHistoryDialogPresented = false

    private (set) var searchHistory: OrderedSet<AnyAppContent> = []
    private (set) var searchResults: [AnyAppContent] = []
    private (set) var searchCategoriesOpacity = 1.0
    private (set) var searchState: SearchState = .categories
    private (set) var allContentList: [AnyAppContent] = []

    private (set) var playerParameters: PlayerParameters?

    func setupPlayerParameters(_ parameters: PlayerParameters) {
        playerParameters = parameters
    }

    func loadContent() {
        let allSongs = (Playlist.examples.flatMap { $0.songs } + Album.examples.flatMap { $0.songs } + [Song.example]).map { AnyAppContent($0) }
        let allPlaylists = Playlist.examples.map { AnyAppContent($0) }
        let allAlbums = Album.examples.map { AnyAppContent($0) }
        allContentList = allPlaylists + allAlbums + allSongs
    }

    func updateSearchState() {
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

    func searchInProgressHandler() {
        playerParameters?.isHidden = isSearchInProgress
        withAnimation(.easeIn(duration: 1).delay(0.1)) {
            searchCategoriesOpacity = isSearchInProgress ? 0 : 1
        }
    }

    func prepareSearchText() {
        searchText = searchText.lowercased()
    }

    func updateSearchResults() {
        if searchText.isEmpty {
            searchResults.removeAll()
        } else {
            performSearch()
        }
    }

    private func performSearch() {
        searchResults = allContentList.filter { $0.title.lowercased().hasPrefix(searchText.lowercased()) }
    }

    func onContentSearchResultTapped(content: AnyAppContent) {
        searchHistory.append(content)
    }

    func onTextSearchResultTapped(title: String) {
        searchText = title
    }

    func onSearchHistoryClearButtonTapped() {
        isClearSearchHistoryDialogPresented = true
    }

    func clearSearchHistory() {
        searchHistory.removeAll()
        isClearSearchHistoryDialogPresented = false
    }
}
