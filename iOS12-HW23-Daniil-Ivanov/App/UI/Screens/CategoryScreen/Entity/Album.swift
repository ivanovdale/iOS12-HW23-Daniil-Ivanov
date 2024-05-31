//
//  Album.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct Album: Identifiable {
    let id = UUID()
    let name: String
    let singer: String
    let image: ImageResource
    let categories: [SearchCategory]
    let songs: [Song]
}
