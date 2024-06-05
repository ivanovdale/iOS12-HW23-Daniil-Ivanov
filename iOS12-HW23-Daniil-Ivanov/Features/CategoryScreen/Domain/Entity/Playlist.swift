//
//  Playlist.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct Playlist: Identifiable {
    let id = UUID()
    let name: String
    let description: String?
    let image: ImageResource
    let categories: [SearchCategory]
    let songs: [Song]
    let isDownloaded: Bool

    init(
        name: String,
        description: String?,
        image: ImageResource,
        categories: [SearchCategory],
        songs: [Song],
        isDownloaded: Bool = false
    ) {
        self.name = name
        self.description = description
        self.image = image
        self.categories = categories
        self.songs = songs
        self.isDownloaded = isDownloaded
    }
}
