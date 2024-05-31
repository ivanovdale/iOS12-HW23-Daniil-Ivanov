//
//  StationsView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 13.05.2024.
//

import SwiftUI

struct StationsView : View {
    let imageSize: CGFloat
    let stations: [RadioStation]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Станции")
                .font(.title)
                .fontWeight(.bold)

            LazyVStack(alignment: .leading) {
                ForEach(stations) { station in
                    HStack(spacing: RadioScreen.Metric.padding) {
                        Image(station.imageName)
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 3))

                        VStack(alignment: .leading, spacing: 6) {
                            Text(station.name)

                            Text(station.shortSummary)
                                .font(.callout)
                                .foregroundStyle(.gray)
                                .lineLimit(1)
                        }
                    }

                    if (station != stations.last) {
                        Divider()
                            .padding(.vertical, RadioScreen.Metric.padding / 2)
                            .padding(.leading, imageSize + RadioScreen.Metric.padding)
                    }
                }
            }
        }
    }
}

#Preview {
    RadioScreen()
}
