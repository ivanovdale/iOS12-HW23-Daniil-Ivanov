//
//  PlayerView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 11.05.2024.
//

import SwiftUI

struct PlayerView: View {
    let height: CGFloat
    let offset: CGFloat

    var body: some View {
        let stackHeight = height
        let verticalPadding = 8.0
        let horizontalPadding = 24.0
        let albumViewSize = stackHeight - verticalPadding * 2 - 1
        let controlHeight = stackHeight * 0.22

        HStack(spacing: 0) {
            AlbumView(width: albumViewSize, height: albumViewSize)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)

            Text("Не исполняется")
                .font(.callout)
                .fontWeight(.light)

            Spacer()

            Image(systemName: "play.fill")
                .resizable()
                .scaledToFit()
                .frame(height: controlHeight)
                .padding(.trailing, 24)

            Image(systemName: "forward.fill")
                .resizable()
                .scaledToFit()
                .frame(height: controlHeight)
                .foregroundStyle(.gray)
                .padding(.trailing, 16)
        }
        .background(.gray.opacity(0.1))
        .frame(height: stackHeight)
        .offset(y: -offset)
    }
}

struct AlbumView: View {
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray
                    .opacity(0.1)
                    .shadow(.drop(color: .black,
                                  radius: 4,
                                  x: 2,
                                  y: 2)))
                .frame(width: width, height: height)
            Image(systemName: "music.note")
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.6, height: height * 0.6)
                .foregroundStyle(.gray.opacity(0.4))
        }
    }
}
