//
//  Song.swift
//  AppleMusic
//
//  Created by Daniil (work) on 12.05.2024.
//

import Foundation

struct Song {
    let title: String
    let singer: String
    let imageName: String
}

extension Song: CustomStringConvertible {
    var description: String {
        "\(singer) - \(title)"
    }
}

extension Song {
    static let example = Song(title: "Let Me In",
                              singer: "Drag Me Out",
                              imageName: "Drag me out - let me in")
}
