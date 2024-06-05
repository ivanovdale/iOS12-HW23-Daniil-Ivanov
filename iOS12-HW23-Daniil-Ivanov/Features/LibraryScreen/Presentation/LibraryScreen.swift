//
//  LibraryView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 11.05.2024.
//

import SwiftUI

enum LibraryPath: Hashable {
    case libraryCategoryList
}

struct LibraryScreen: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Ищете свою музыку?")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Здесь появится купленная Вами в iTunes Store музыка.")
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationTitle("Медиатека")
            .toolbar {
                NavigationLink(value: LibraryPath.libraryCategoryList) {
                    Text("Править")
                        .foregroundStyle(.red)
                }
            }
            .navigationDestination(for: LibraryPath.self) { path in
                switch path {
                case .libraryCategoryList:
                    LibraryCategoryListScreen()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LibraryScreen()
    }
}
