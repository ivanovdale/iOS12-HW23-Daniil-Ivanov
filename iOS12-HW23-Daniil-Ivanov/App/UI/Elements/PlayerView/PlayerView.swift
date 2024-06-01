//
//  PlayerView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 11.05.2024.
//

import SwiftUI

struct PlayerView: View {
    let offset: CGFloat

    var stackHeight: Double {
        parameters.height
    }

    @Environment(PlayerParameters.self)
    var parameters

    @State 
    private var song: Song? = Song.example

    @State
    private var isPlaying = false

    var body: some View {
        let albumViewSize = calculateAlbumViewSize()
        let controlHeight = stackHeight * 0.22
        let title = song?.description ?? "Не исполняется"

        HStack(spacing: 0) {
            AlbumView(
                width: albumViewSize,
                height: albumViewSize,
                image: song?.image
            )
            .padding(.horizontal, Metric.horizontalPadding)
            .padding(.vertical, Metric.verticalPadding)

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
        .opacity(parameters.isHidden ? 0 : 1)
    }

    private func calculateAlbumViewSize() -> Double {
        if stackHeight > 0 {
            stackHeight - Metric.verticalPadding * 2 - 1
        } else {
            0
        }
    }

    // MARK: - Constants

    private enum Metric {
        static let verticalPadding = 8.0
        static let horizontalPadding = 24.0
    }
}

// MARK: Environment extension

@Observable
class PlayerParameters {
    let height = 55.0
    var isHidden = false
}

#Preview {
    MainFlow()
}
