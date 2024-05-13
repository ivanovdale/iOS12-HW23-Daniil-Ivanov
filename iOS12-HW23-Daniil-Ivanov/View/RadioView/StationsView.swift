//
//  StationsView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 13.05.2024.
//

import SwiftUI

struct StationsView : View {
    let imageSize: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text("Станции")
                .font(.title)
                .fontWeight(.bold)

            LazyVStack(alignment: .leading) {
                ForEach(0..<5) {_ in
                    HStack(spacing: RadioView.Metric.padding) {
                        Image("Cover2")
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 3))

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Популярное")

                            Text("То, что слушают прямо сейчас.")
                                .font(.callout)
                                .foregroundStyle(.gray)
                                .lineLimit(1)
                        }
                    }

                    Divider()
                        .padding(.vertical, RadioView.Metric.padding / 2)
                        .padding(.leading, imageSize + RadioView.Metric.padding)
                }
            }
        }
    }
}
