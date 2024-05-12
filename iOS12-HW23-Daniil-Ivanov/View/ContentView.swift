//
//  ContentView.swift
//  iOS12-HW23-Daniil-Ivanov
//
//  Created by Daniil (work) on 11.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            AppTabView()
                .safeAreaInset(edge: .bottom) {
                    PlayerView(height: geometry.size.height * 0.1,
                               offset: 50)
                }
        }
    }
}
