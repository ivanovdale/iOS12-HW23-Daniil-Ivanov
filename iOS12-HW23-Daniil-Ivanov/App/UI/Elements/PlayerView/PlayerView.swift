//
//  PlayerView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 11.05.2024.
//

import SwiftUI

struct PlayerView: View {
    let offset: CGFloat
    @Environment(\.playerHeight) var height: Double

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

// MARK: Environment extension

private struct PlayerHeight: EnvironmentKey {
    typealias Value = Double
    static let defaultValue: Double = 50
}

extension EnvironmentValues {
    var playerHeight: Double {
        get { self[PlayerHeight.self] }
        set { self[PlayerHeight.self] = newValue }
    }
}

extension View {
    func playerHeight(_ height: Double) -> some View {
        environment(\.playerHeight, height)
    }
}

#Preview {
    MainFlow()
}
