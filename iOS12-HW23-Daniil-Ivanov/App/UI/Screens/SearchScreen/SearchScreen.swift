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
    @State
    private var searchText = ""

    @State
    private var isSearchInProgress = false
    @Environment(PlayerParameters.self)
    var playerParameters

    let categories = SearchCategory.examples

    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("Поиск по категориям")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3)
                .fontWeight(.bold)

            SearchCategoriesView(categories: categories)

            Color.clear.frame(height: playerParameters.height)
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
            prompt: "Ваша Медиатека"
        )
        .onChange(of: isSearchInProgress) { oldValue, newValue in
            playerParameters.isHidden = newValue
        }
    }
}

private struct SearchCategoriesView: View {
    let categories: [SearchCategory]

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(categories) { category in
                SearchCategoryItemView(category: category)
            }
        }
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

#Preview {
    SearchScreen()
}

#Preview {
    MainFlow()
}

