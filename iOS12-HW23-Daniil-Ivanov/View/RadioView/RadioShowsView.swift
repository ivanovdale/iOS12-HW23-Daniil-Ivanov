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

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: RadioView.Metric.padding) {
                ForEach(0..<100, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text("ЭКСКЛЮЗИВ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)

                        Text("Название шоу Название шоу Название шоу")
                            .font(.title2)

                        if index == 0 {
                            Spacer()
                                .frame(maxHeight: 43)
                        } else {
                            Text("Краткое описание Краткое описание Краткое описание")
                                .font(.title2)
                                .foregroundStyle(.gray)
                                .lineLimit(1)
                        }

                        Image("Cover1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: contentWidth - RadioView.Metric.padding * 3,
                                   height: height * 0.7)
                            .clipShape(RoundedRectangle(cornerRadius: 6))

                    }
                    .frame(width: contentWidth - RadioView.Metric.padding * 3)
                }
            }
            .padding(.leading, RadioView.Metric.padding)
            .frame(height: height)
        }
    }
}
