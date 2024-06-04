//
//  Album+Ext.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import Foundation

extension Album: AppContent {
    var description: String? {
        nil
    }

    var title: String {
        name
    }

    var subtitle: String? {
        singer
    }

    var secondaryTitle: String {
        "избранный альбом".uppercased()
    }

    var type: String {
        "альбом".capitalized
    }

    static func == (lhs: Album, rhs: Album) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Album {
    static let examples: [Album] = [
        Album(
            name: "Greatest Hits",
            singer: "Famous Artist",
            image: .cover1,
            categories: [
                SearchCategory.examples[0],
                SearchCategory.examples[1]
            ],
            songs: [
                Song(title: "Hit Song 1", singer: "Famous Artist", image: .cover1),
                Song(title: "Hit Song 2", singer: "Famous Artist", image: .cover2)
            ]
        ),
        Album(
            name: "Classical Melodies",
            singer: "Renowned Composer",
            image: .cover2,
            categories: [
                SearchCategory.examples[2],
                SearchCategory.examples[3]
            ],
            songs: [
                Song(title: "Symphony No. 1", singer: "Renowned Composer", image: .cover3, isDownloaded: true),
                Song(title: "Concerto in D", singer: "Renowned Composer", image: .cover4, isDownloaded: true)
            ]
        ),
        Album(
            name: "Jazz Vibes",
            singer: "Smooth Jazz Band",
            image: .cover3,
            categories: [
                SearchCategory.examples[4],
                SearchCategory.examples[5]
            ],
            songs: [
                Song(title: "Smooth Groove", singer: "Smooth Jazz Band", image: .cover5, isDownloaded: true),
                Song(title: "Late Night Blues", singer: "Smooth Jazz Band", image: .cover1, isDownloaded: true)
            ]
        ),
        Album(
            name: "Electronic Essentials",
            singer: "DJ Producer",
            image: .cover4,
            categories: [
                SearchCategory.examples[6],
                SearchCategory.examples[7]
            ],
            songs: [
                Song(title: "Beat Drop", singer: "DJ Producer", image: .cover2, isDownloaded: true),
                Song(title: "Dance Floor", singer: "DJ Producer", image: .cover3, isDownloaded: true)
            ]
        ),
        Album(
            name: "Acoustic Sessions",
            singer: "Indie Singer",
            image: .cover5,
            categories: [
                SearchCategory.examples[8],
                SearchCategory.examples[9]
            ],
            songs: [
                Song(title: "Strumming Along", singer: "Indie Singer", image: .cover4),
                Song(title: "Quiet Nights", singer: "Indie Singer", image: .cover5)
            ]
        )
    ]
}
