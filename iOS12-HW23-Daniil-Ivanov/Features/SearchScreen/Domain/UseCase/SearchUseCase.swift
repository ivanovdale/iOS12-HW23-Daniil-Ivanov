//
//  SearchUseCase.swift
//  AppleMusic
//
//  Created by Daniil (work) on 05.06.2024.
//

import Foundation

protocol SearchUseCase {
    func fetchContent() async -> [AnyAppContent]
    func searchContent(query: String) async -> [AnyAppContent]
}

final class SearchInteractor: SearchUseCase {
    private var allContentList: [AnyAppContent] = []

    func fetchContent() async -> [AnyAppContent] {
        let allSongs = (Playlist.examples.flatMap { $0.songs } + Album.examples.flatMap { $0.songs } + [Song.example]).map { AnyAppContent($0) }
        let allPlaylists = Playlist.examples.map { AnyAppContent($0) }
        let allAlbums = Album.examples.map { AnyAppContent($0) }
        allContentList = allPlaylists + allAlbums + allSongs

        return allContentList
    }

    func searchContent(query: String) async -> [AnyAppContent] {
        allContentList.filter { $0.title.lowercased().hasPrefix(query) }
    }
}
