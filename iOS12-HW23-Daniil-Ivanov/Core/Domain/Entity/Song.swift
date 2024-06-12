//
//  Song.swift
//  AppleMusic
//
//  Created by Daniil (work) on 12.05.2024.
//

import SwiftUI

struct Song {
    private static let defaultDuration = 150.0

    let id = UUID()
    let title: String
    let singer: String
    let image: ImageResource
    let isDownloaded: Bool
    let duration: TimeInterval

    init(
        title: String,
        singer: String,
        image: ImageResource,
        isDownloaded: Bool = false,
        duration: TimeInterval = Self.defaultDuration
    ) {
        self.title = title
        self.singer = singer
        self.image = image
        self.isDownloaded = isDownloaded
        self.duration = duration
    }
}

extension Song {
    static let example = Song(title: "Let Me In",
                              singer: "Drag Me Out",
                              image: .dragMeOutLetMeIn,
                              duration: 252.0)
}
