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
    private var scope: SearchScope = .appleMusic
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
        }

    }
}
#Preview {
    SearchScreen()
}

#Preview {
    MainFlow()
}

