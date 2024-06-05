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

    private (set) var playerParameters: PlayerParameters?

    private let searchInteractor: SearchUseCase

    init(searchInteractor: SearchUseCase) {
        self.searchInteractor = searchInteractor
    }

    func setupPlayerParameters(_ parameters: PlayerParameters) {
        playerParameters = parameters
    }

    func loadContent() async {
        await searchInteractor.loadContent()
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
            Task {
                await performSearch()
            }

        }
    }

    private func performSearch() async {
        let searchResults = await searchInteractor.searchContent(query: searchText.lowercased())
        DispatchQueue.main.async {
            self.searchResults = searchResults
        }
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
