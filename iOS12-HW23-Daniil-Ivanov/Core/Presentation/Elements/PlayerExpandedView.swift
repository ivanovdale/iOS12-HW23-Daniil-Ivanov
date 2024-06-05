//
//  PlayerExpandedView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 05.06.2024.
//

import SwiftUI

struct PlayerExpandedView: View {
    let song: Song

    @State
    private var isPlaying = false

    @State
    private var songCurrentTimeValue = 0.0

    @State
    private var songDurationTimeLeft = 0.0

    @State
    private var timer: Timer?

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(maxHeight: 100)
            AlbumCoverView(image: song.image)
            Spacer().frame(maxHeight: 120)
            SongTitleSingerView(
                title: song.title,
                singer: song.singer
            )
            Slider(
                value: $songCurrentTimeValue,
                in: 0...song.duration
            )
            .accentColor(.white)
            .padding(.top, 12)
            SongTimeView(
                currentTime: songCurrentTimeValue,
                timeLeft: songDurationTimeLeft
            )
            PlayerControlsView(
                isPlaying: isPlaying,
                onPlayPausePressed: togglePlayPause
            )
            VolumeControlsView()
            ExtraButtonsView()

            Spacer().frame(maxHeight: 30)
        }
        .padding(.horizontal, 36)
        .background(Image(song.image)
            .resizable()
            .blur(radius: 90)
            .edgesIgnoringSafeArea(.all)
        )
        .background(Color.gray.edgesIgnoringSafeArea(.all))
        .onAppear {
            songDurationTimeLeft = song.duration
            prepareSlider()
        }
        .onChange(of: songCurrentTimeValue) { _, _ in
            songDurationTimeLeft = song.duration - songCurrentTimeValue
        }
    }

    private func prepareSlider() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 10)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        UISlider.appearance().setThumbImage(image, for: .normal)
    }

    private func togglePlayPause() {
        isPlaying.toggle()
        if isPlaying {
            startTimer()
        } else {
            stopTimer()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if songCurrentTimeValue < song.duration {
                songCurrentTimeValue += 1
            } else {
                stopTimer()
                isPlaying = false
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

private struct AlbumCoverView: View {
    let image: ImageResource

    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: 250, maxHeight: 250)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

private struct SongTitleSingerView: View {
    let title: String
    let singer: String

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .fontWeight(.bold)
                Text(singer)
            }
            .font(.title3)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            Spacer()
            Button(action: {}, label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .background(.gray)
                    .opacity(0.5)
                    .clipShape(Circle())
            })
        }
    }
}

private struct SongTimeView: View {
    let currentTime: Double
    let timeLeft: Double

    var body: some View {
        HStack {
            Text(formatTime(currentTime))
                .foregroundColor(.white)
            Spacer()
            Text("-\(formatTime(timeLeft))")
                .foregroundColor(.white)
        }
        .font(.caption)
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

private struct PlayerControlsView: View {
    let isPlaying: Bool
    let onPlayPausePressed: () -> Void

    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "backward.fill").font(.title)
            }
            Spacer()
            Button(action: {
                onPlayPausePressed()
            }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "forward.fill").font(.title)
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 50)
        .padding(.top, 30)
    }
}


private struct VolumeControlsView: View {
    @State
    private var volumeValue: Double = 0.4

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "speaker.fill")
            // FIXME: Некорректный размер круглешочка слайдера, устанавливается глобально
            Slider(value: $volumeValue)
                .accentColor(.white)
            Image(systemName: "speaker.wave.3.fill")

        }
        .foregroundStyle(.white.opacity(0.6))
        .padding(.top, 30)
    }
}

private struct ExtraButtonsView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "quote.bubble")
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "airplayaudio")
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "shuffle")
            }
        }
        .foregroundColor(.white.opacity(0.6))
        .font(.title2)
        .padding(.horizontal, 50)
        .padding(.top, 20)
    }
}

#Preview {
    PlayerExpandedView(song: Song.example)
}
