//
//  Song.swift
//  AppleMusic
//
//  Created by Daniil (work) on 12.05.2024.
//

import SwiftUI

struct Song {
    let id = UUID()
    let title: String
    let singer: String
    let image: ImageResource
    let isDownloaded: Bool

    init(
        title: String,
        singer: String,
        image: ImageResource,
        isDownloaded: Bool = false
    ) {
        self.title = title
        self.singer = singer
        self.image = image
        self.isDownloaded = isDownloaded
    }
}

extension Song {
    static let example = Song(title: "Let Me In",
                              singer: "Drag Me Out",
                              image: .dragMeOutLetMeIn)
}
