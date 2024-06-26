//
//  Song+Ext.swift
//  AppleMusic
//
//  Created by Daniil (work) on 01.06.2024.
//

import Foundation

extension Song: AppContent {
    var description: String? {
        "\(singer) - \(title)"
    }

    var subtitle: String? {
        singer
    }

    var secondaryTitle: String {
        "избранная песня".uppercased()
    }

    var type: String {
        "песня".capitalized
    }

    static func == (lhs: Song, rhs: Song) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
