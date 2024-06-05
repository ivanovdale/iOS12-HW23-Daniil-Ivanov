//
//  SearchScreen.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI
import OrderedCollections

enum SearchPath: Hashable {
    case category(SearchCategory)
}

struct SearchScreen: View {
    @Environment(PlayerParameters.self)
    private var playerParameters

    @State
    private var viewModel = SearchViewModel(searchInteractor: SearchInteractor())

    let categories = SearchCategory.examples

    var body: some View {
        ScrollView(showsIndicators: false) {
            makeSearchView()
        }
        .padding(.horizontal, 16)
        .searchable(
            text: $viewModel.searchText,
            isPresented: $viewModel.isSearchInProgress,
            placement: .navigationBarDrawer,
            prompt: "Ваша Медиатека"
        )
        .searchScopes($viewModel.scope, activation: .onSearchPresentation) {
            ForEach(SearchViewModel.SearchScope.allCases, id: \.self) { scope in
                Text(scope.rawValue).tag(scope)
            }
        }
        .task {
            await viewModel.loadContent()
        }
        .onAppear {
            viewModel.setupPlayerParameters(playerParameters)
        }
        .onChange(of: viewModel.isSearchInProgress) { _, _ in
            viewModel.updateSearchState()
            viewModel.searchInProgressHandler()
        }
        .onChange(of: viewModel.searchText) { _, _ in
            viewModel.updateSearchState()
            viewModel.prepareSearchText()
            viewModel.updateSearchResults()
        }
        .onChange(of: viewModel.searchHistory) { _, _ in
            viewModel.updateSearchState()
        }
        .onChange(of: viewModel.isClearSearchHistoryDialogPresented) { _, _ in
            viewModel.updateSearchState()
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
            isPresented: $viewModel.isClearSearchHistoryDialogPresented,
            titleVisibility: .hidden
        ) {
            Button(role: .destructive) {
                viewModel.clearSearchHistory()
                viewModel.isClearSearchHistoryDialogPresented = false
            } label: {
                Text("Очистить недавние поиски")
            }
        }
    }

    @ViewBuilder
    private func makeSearchView() -> some View {
        switch viewModel.searchState {
        case .categories:
            SearchCategoriesView(categories: categories)
                .opacity(viewModel.searchCategoriesOpacity)
        case .results, .history, .historyEmpty:
            makeSearchResultsOrHistoryView()
        }
    }

    @ViewBuilder
    private func makeSearchResultsOrHistoryView() -> some View {
        switch viewModel.searchState {
        case .results:
            SearchResultsView(
                searchResults: viewModel.searchResults,
                searchText: viewModel.searchText,
                onContentSearchResultTapped: viewModel.onContentSearchResultTapped(content:),
                onTextSearchResultTapped: viewModel.onTextSearchResultTapped(title:)
            )
        case .history:
            SearchHistoryView(
                searchHistory: Array(viewModel.searchHistory),
                onClearButtonTapped: viewModel.onSearchHistoryClearButtonTapped
            )
        case .historyEmpty, .categories:
            EmptyView()
        }
    }
}

// MARK: - DEBUG

#Preview {
    MainFlow()
}

