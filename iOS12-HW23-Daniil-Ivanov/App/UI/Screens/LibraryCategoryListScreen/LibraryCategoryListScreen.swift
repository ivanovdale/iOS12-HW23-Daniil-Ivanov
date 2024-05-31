//
//  CategoryListView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 12.05.2024.
//

import SwiftUI

struct LibraryCategoryListScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var categories = LibraryCategory.allCases
    @State private var editMode: EditMode = .active
    @State private var multiSelection = Set<LibraryCategory>()

    var body: some View {
        List(selection: $multiSelection) {
            ForEach(categories, id: \.id) { category in
                HStack {
                    Image(systemName: category.imageName)
                        .foregroundStyle(.red)
                        .frame(width: 30)
                    Text(category.description)
                }
                .listRowSeparator(.visible, edges: .all)
            }
            .onMove(perform: move)
        }
        .navigationTitle("Медиатека")
        .toolbar {
            Button("Готово") {
                dismiss()
            }
            .foregroundStyle(.red)
            .fontWeight(.bold)
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .environment(\.editMode, $editMode)
        .tint(.red)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            UINavigationBar.setAnimationsEnabled(false)
        }
        .onDisappear {
            UINavigationBar.setAnimationsEnabled(true)
        }
    }

    private func move(from source: IndexSet, to destination: Int) {
        categories.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    LibraryCategoryListScreen()
}
