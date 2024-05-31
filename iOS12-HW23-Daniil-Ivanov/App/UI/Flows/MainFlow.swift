//
//  MainFlow.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct MainFlow: View {
    var body: some View {
        GeometryReader { geometry in
            AppTabView()
                .safeAreaInset(edge: .bottom) {
                    PlayerView(height: geometry.size.height * 0.1,
                               offset: 49)
                }
        }
    }
}

#Preview {
    MainFlow()
}
