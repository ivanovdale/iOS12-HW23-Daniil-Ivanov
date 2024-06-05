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
        AppContentListView(
            height: height,
            contentWidth: contentWidth,
            content: radioShows,
            spacing: nil,
            leadingPadding: RadioScreen.Metric.padding
        )
    }
}

#Preview {
    RadioScreen()
}
