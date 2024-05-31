//
//  Song.swift
//  AppleMusic
//
//  Created by Daniil (work) on 12.05.2024.
//

import SwiftUI

struct Song {
    let title: String
    let singer: String
    let image: ImageResource
}

extension Song: CustomStringConvertible {
    var description: String {
        "\(singer) - \(title)"
    }
}

extension Song {
    static let example = Song(title: "Let Me In",
                              singer: "Drag Me Out",
                              image: .dragMeOutLetMeIn)
}
