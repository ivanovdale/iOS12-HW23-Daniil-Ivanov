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

    @State private var song: Song? = Song.example
    @State private var isPlaying = false

    var body: some View {
        let stackHeight = height
        let verticalPadding = 8.0
        let horizontalPadding = 24.0
        let albumViewSize = stackHeight - verticalPadding * 2 - 1
        let controlHeight = stackHeight * 0.22
        let title = song?.description ?? "Не исполняется"

        HStack(spacing: 0) {
            AlbumView(width: albumViewSize,
                      height: albumViewSize,
                      imageName: song?.imageName)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)

            Text(title)
                .font(.callout)
                .fontWeight(.light)

            Spacer()

            Button(action: {
                guard song != nil else { return }
                isPlaying = !isPlaying
            }, label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: controlHeight)
                    .foregroundStyle(.black)
                    .padding(.trailing, 24)
            })

            Button(action: {
                song = nil
                isPlaying = false
            }, label: {
                Image(systemName: "forward.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: controlHeight)
                    .foregroundStyle(song != nil ? .black : .gray)
                    .padding(.trailing, 16)
            })
        }
        .background(Color(UIColor.systemGray6))
        .frame(height: stackHeight)
        .offset(y: -offset)
    }
}

struct AlbumView: View {
    let width: CGFloat
    let height: CGFloat
    let imageName: String?

    var body: some View {
        Group {
            let shadowColor = Color.gray.opacity(0.5)

            if let imageName {
                // Album image
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: shadowColor, radius: 4, x: 0, y: 3)
            } else {
                // Placeholder image
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.systemGray5))
                        .frame(width: width, height: height)
                        .shadow(color: shadowColor, radius: 4, x: 0, y: 3)
                    Image(systemName: "music.note")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width * 0.6, height: height * 0.6)
                        .foregroundStyle(Color(UIColor.systemGray3))
                }
            }
        }
    }
}
