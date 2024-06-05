//
//  SearchDataSource.swift
//  AppleMusic
//
//  Created by Daniil (work) on 05.06.2024.
//

import Foundation

protocol DataSource {
    func fetchContent() async -> [AnyAppContent]
}

final class MockDataSource: DataSource {
    func fetchContent() async -> [AnyAppContent] {
        let allSongs = (Playlist.examples.flatMap { $0.songs } + Album.examples.flatMap { $0.songs } + [Song.example]).map { AnyAppContent($0) }
        let allPlaylists = Playlist.examples.map { AnyAppContent($0) }
        let allAlbums = Album.examples.map { AnyAppContent($0) }
        return allPlaylists + allAlbums + allSongs
    }
}
