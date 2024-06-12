//
//  MainFlow.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct MainFlow: View {
    @State
    private var playerParameters = PlayerParameters()

    var body: some View {
        GeometryReader { geometry in
            AppTabView()
                .safeAreaInset(edge: .bottom) {
                    PlayerView(offset: 48.5)
                }
                .environment(playerParameters)
        }
    }
}

#Preview {
    MainFlow()
}
