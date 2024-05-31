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
}
