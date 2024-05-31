//
//  TabView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 11.05.2024.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            ForEach(Tab.allCases, content: tabView(_:))
        }
        .accentColor(.red)
        .onAppear() {
            let appearance = UITabBarAppearance()
            appearance.shadowColor = .systemGray2
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    private func tabView(_ tab: Tab) -> some View {
        tab.content
            .tabItem {
                Image(systemName: tab.imageName)
                Text(tab.title)
            }
    }
}

// MARK: - Tab values

fileprivate enum Tab: CaseIterable {
    case mediaLibrary, radio, search
}

// MARK: - Tab extension

extension Tab: Identifiable {
    var id: Self { self }
}

extension Tab {
    var imageName: String {
        switch self {
        case .mediaLibrary: return "music.note.house.fill"
        case .radio: return "dot.radiowaves.left.and.right"
        case .search: return "magnifyingglass"
        }
    }

    var title: String {
        switch self {
        case .mediaLibrary: return "Медиатека"
        case .radio: return "Радио"
        case .search: return "Поиск"
        }
    }

    // MARK: ViewBuilder

    @ViewBuilder
    var content: some View {
        switch self {
        case .mediaLibrary: LibraryScreen()
        case .radio: RadioScreen()
        case .search: Text(self.title)
        }
    }
}

#Preview {
    MainFlow()
}
