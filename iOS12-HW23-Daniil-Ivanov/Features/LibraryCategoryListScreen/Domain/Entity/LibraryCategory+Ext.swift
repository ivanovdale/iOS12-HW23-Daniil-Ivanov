//
//  Category+Ext.swift
//  AppleMusic
//
//  Created by Daniil (work) on 12.05.2024.
//

import Foundation

extension LibraryCategory: Identifiable {
    var id: Self { self }
}

extension LibraryCategory: CustomStringConvertible {
    var description: String {
        switch (self) {
        case .playlists: return "Плейлисты"
        case .artists: return "Артисты"
        case .albums: return "Альбомы"
        case .songs: return "Песни"
        case .tvAndMovies: return "Телешоу и фильмы"
        case .musicVideos: return "Видеоклипы"
        case .genres: return "Жанры"
        case .compilations: return "Сборники"
        case .composers: return "Авторы"
        case .downloaded: return "Загружено"
        case .homeSharing: return "Домашняя коллекция"
        }
    }
}

extension LibraryCategory {
    var imageName: String {
        switch (self) {
        case .playlists: return "music.note.list"
        case .artists: return "music.mic"
        case .albums: return "square.stack"
        case .songs: return "music.note"
        case .tvAndMovies: return "tv"
        case .musicVideos: return "music.note.tv"
        case .genres: return "guitars"
        case .compilations: return "person.2.crop.square.stack"
        case .composers: return "music.quarternote.3"
        case .downloaded: return "arrow.down.circle"
        case .homeSharing: return "music.note.house"
        }
    }
}
