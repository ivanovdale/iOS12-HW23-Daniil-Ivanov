//
//  RadioShowsView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 13.05.2024.
//

import SwiftUI

struct RadioShowsView: View {
    let height: CGFloat
    let contentWidth: CGFloat
    let radioShows: [RadioShow]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: RadioView.Metric.padding) {
                ForEach(radioShows) { radioShow in
                    VStack(alignment: .leading) {
                        Text(radioShow.tag.rawValue.uppercased())
                            .font(.subheadline)
                            .foregroundStyle(.gray)

                        Text("Название шоу Название шоу Название шоу")
                            .font(.title2)

                        if let shortSummary = radioShow.shortSummary {
                            Text(shortSummary)
                                .font(.title2)
                                .foregroundStyle(.gray)
                                .lineLimit(1)
                        } else {
                            Spacer()
                                .frame(maxHeight: 43)
                        }

                        Image(radioShow.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: contentWidth - RadioView.Metric.padding * 3,
                                   height: height * 0.7)
                            .clipShape(RoundedRectangle(cornerRadius: 6))

                    }
                    .frame(width: contentWidth - RadioView.Metric.padding * 3)
                }

                Color.clear.frame(width: RadioView.Metric.padding / 2)

            }
            .padding(.leading, RadioView.Metric.padding)
            .frame(height: height)
        }
    }
}
