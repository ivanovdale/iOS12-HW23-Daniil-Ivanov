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
            LazyHStack(spacing: RadioScreen.Metric.padding) {
                ForEach(radioShows) { radioShow in
                    AppContentView(
                        title: radioShow.name,
                        shortSummary: radioShow.shortSummary,
                        tag: radioShow.tag.rawValue,
                        image: radioShow.image,
                        imageHeight: height * 0.67
                    )
                    .frame(maxWidth: contentWidth)
                }

                // Trailing padding
                Color.clear.frame(maxWidth: 0)
            }
            .padding(.leading, RadioScreen.Metric.padding)
        }
    }
}

#Preview {
    RadioScreen()
}
