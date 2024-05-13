//
//  RadioView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 13.05.2024.
//

import SwiftUI

struct RadioView: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView(.vertical) {
                    Divider()
                        .padding(Metric.padding)

                    RadioShowsView(height: geometry.size.height * 0.4,
                                   contentWidth: geometry.size.width)

                    Divider()
                        .padding(Metric.padding)
                }
                .navigationTitle("Радио")
            }
        }
    }

    // MARK: - Constants
    enum Metric {
        static let padding = 16.0
    }
}

