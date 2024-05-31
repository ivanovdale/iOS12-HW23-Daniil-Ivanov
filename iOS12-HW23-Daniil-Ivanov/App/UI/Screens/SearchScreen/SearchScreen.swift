//
//  SearchScreen.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct SearchScreen: View {
    @State private var searchText = ""
    @Environment(\.playerHeight) var playerHeight: Double
    let categories = SearchCategory.examples

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                Text("Поиск по категориям")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                    .fontWeight(.bold)
                
                SearchCategoriesView(categories: categories)

                Color.clear.frame(height: playerHeight)
            }
            .navigationTitle("Поиск")
            .padding(.horizontal, 16)
        }
        .searchable(text: $searchText, prompt: "Ваша Медиатека")
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

#Preview {
    SearchScreen()
}

#Preview {
    MainFlow()
}

