//
//  RadioView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 13.05.2024.
//

import SwiftUI

struct RadioScreen: View {
    @Environment(\.playerHeight) var playerHeight: Double

    private let radioShows = RadioShow.examples
    private let radioStations = RadioStation.examples

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView(.vertical) {
                    Divider()
                        .padding(Metric.padding)

                    RadioShowsView(height: geometry.size.height * 0.4,
                                   contentWidth: geometry.size.width,
                                   radioShows: radioShows)

                    Divider()
                        .padding([.horizontal, .top], Metric.padding)

                    StationsView(imageSize: geometry.size.height * 0.15,
                                 stations: radioStations)
                        .padding([.horizontal, .top], Metric.padding)

                    Color.clear.frame(height: playerHeight)
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

#Preview {
    RadioScreen()
}
