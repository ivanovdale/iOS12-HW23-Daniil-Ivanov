//
//  Playlist+Ext.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import Foundation

extension Playlist: AppContent {
    var title: String {
        name
    }
    
    var subtitle: String? {
        categories.first?.name
    }
    
    var secondaryTitle: String {
        "FEATURED PLAYLIST"
    }

    var type: String {
        "плейлист".capitalized
    }

    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Playlist {
    static let examples: [Playlist] = [
        Playlist(
            name: "Chill Vibes",
            description: "Relax and unwind with these chill tracks.",
            image: .cover1,
            categories: [SearchCategory.examples[0], SearchCategory.examples[2]],
            songs: [
                Song(title: "Ocean Eyes", singer: "Billie Eilish", image: .cover2),
                Song(title: "Lost in Japan", singer: "Shawn Mendes", image: .cover3),
                Song(title: "Breathe", singer: "Jax Jones", image: .cover4),
                Song(title: "Sunflower", singer: "Post Malone", image: .cover5),
                Song(title: "Better Now", singer: "Post Malone", image: .cover3)
            ]
        ),
        Playlist(
            name: "Workout Mix",
            description: "Get pumped with these high-energy tracks.",
            image: .cover2,
            categories: [SearchCategory.examples[7], SearchCategory.examples[4]],
            songs: [
                Song(title: "Stronger", singer: "Kanye West", image: .cover1),
                Song(title: "Eye of the Tiger", singer: "Survivor", image: .cover3),
                Song(title: "Lose Yourself", singer: "Eminem", image: .cover4),
                Song(title: "Can't Hold Us", singer: "Macklemore & Ryan Lewis", image: .cover5),
                Song(title: "Uptown Funk", singer: "Mark Ronson ft. Bruno Mars", image: .cover1),
                Song(title: "Thunderstruck", singer: "AC/DC", image: .cover1),
                Song(title: "Welcome to the Jungle", singer: "Guns N' Roses", image: .cover2)
            ]
        ),
        Playlist(
            name: "Party Hits",
            description: "Turn up the volume with these party anthems.",
            image: .cover3,
            categories: [SearchCategory.examples[2], SearchCategory.examples[7]],
            songs: [
                Song(title: "Blinding Lights", singer: "The Weeknd", image: .cover4),
                Song(title: "Shape of You", singer: "Ed Sheeran", image: .cover5),
                Song(title: "Sorry", singer: "Justin Bieber", image: .cover1),
                Song(title: "Uptown Funk", singer: "Mark Ronson ft. Bruno Mars", image: .cover1),
                Song(title: "Cheap Thrills", singer: "Sia", image: .cover2),
                Song(title: "24K Magic", singer: "Bruno Mars", image: .cover3),
                Song(title: "Havana", singer: "Camila Cabello", image: .cover4),
                Song(title: "Rockstar", singer: "Post Malone", image: .cover5)
            ]
        ),
        Playlist(
            name: "Top 40",
            description: "The hottest tracks right now.",
            image: .cover4,
            categories: [SearchCategory.examples[2], SearchCategory.examples[7]],
            songs: [
                Song(title: "Peaches", singer: "Justin Bieber", image: .cover1),
                Song(title: "Levitating", singer: "Dua Lipa", image: .cover2),
                Song(title: "Save Your Tears", singer: "The Weeknd", image: .cover3),
                Song(title: "Good 4 U", singer: "Olivia Rodrigo", image: .cover4),
                Song(title: "Kiss Me More", singer: "Doja Cat", image: .cover5),
                Song(title: "Montero", singer: "Lil Nas X", image: .cover4)
            ]
        ),
        Playlist(
            name: "Throwback",
            description: "Blast from the past with these classic hits.",
            image: .cover5,
            categories: [SearchCategory.examples[8], SearchCategory.examples[9]],
            songs: [
                Song(title: "Billie Jean", singer: "Michael Jackson", image: .cover4),
                Song(title: "Like a Prayer", singer: "Madonna", image: .cover1),
                Song(title: "Smells Like Teen Spirit", singer: "Nirvana", image: .cover2),
                Song(title: "Wonderwall", singer: "Oasis", image: .cover3),
                Song(title: "Livin' on a Prayer", singer: "Bon Jovi", image: .cover4),
                Song(title: "Bohemian Rhapsody", singer: "Queen", image: .cover5),
                Song(title: "Sweet Child O' Mine", singer: "Guns N' Roses", image: .cover3),
                Song(title: "Hey Jude", singer: "The Beatles", image: .cover1),
                Song(title: "Dancing Queen", singer: "ABBA", image: .cover2)
            ]
        ),
        Playlist(
            name: "Acoustic",
            description: "Stripped-down and raw acoustic tracks.",
            image: .cover5,
            categories: [SearchCategory.examples[2], SearchCategory.examples[3]],
            songs: [
                Song(title: "Tenerife Sea", singer: "Ed Sheeran", image: .cover3),
                Song(title: "Skinny Love", singer: "Bon Iver", image: .cover4),
                Song(title: "Heartbeats", singer: "Jose Gonzalez", image: .cover5),
                Song(title: "The A Team", singer: "Ed Sheeran", image: .cover5),
                Song(title: "Fast Car", singer: "Tracy Chapman", image: .cover1),
                Song(title: "Banana Pancakes", singer: "Jack Johnson", image: .cover2),
                Song(title: "Let Her Go", singer: "Passenger", image: .cover3)
            ]
        ),
        Playlist(
            name: "Indie Favorites",
            description: "The best of the indie music scene.",
            image: .cover1,
            categories: [SearchCategory.examples[2], SearchCategory.examples[3]],
            songs: [
                Song(title: "Electric Feel", singer: "MGMT", image: .cover4),
                Song(title: "Take Me Out", singer: "Franz Ferdinand", image: .cover5),
                Song(title: "Pumped Up Kicks", singer: "Foster The People", image: .cover5),
                Song(title: "Dog Days Are Over", singer: "Florence + The Machine", image: .cover1),
                Song(title: "Young Folks", singer: "Peter Bjorn and John", image: .cover2),
                Song(title: "Wake Up", singer: "Arcade Fire", image: .cover3),
                Song(title: "Fluorescent Adolescent", singer: "Arctic Monkeys", image: .cover4),
                Song(title: "Feel It Still", singer: "Portugal. The Man", image: .cover5),
                Song(title: "Electric Love", singer: "BØRNS", image: .cover5),
                Song(title: "Tongue Tied", singer: "Grouplove", image: .cover1)
            ]
        ),
        Playlist(
            name: "Country Roads",
            description: "Country hits for the open road.",
            image: .cover2,
            categories: [
                SearchCategory.examples[2],
                SearchCategory.examples[6],
                SearchCategory.examples[0]
            ],
            songs: [
                Song(title: "Take Me Home, Country Roads", singer: "John Denver", image: .cover3),
                Song(title: "Jolene", singer: "Dolly Parton", image: .cover4),
                Song(title: "Ring of Fire", singer: "Johnny Cash", image: .cover5),
                Song(title: "The Gambler", singer: "Kenny Rogers", image: .cover2),
                Song(title: "Friends in Low Places", singer: "Garth Brooks", image: .cover1),
                Song(title: "Need You Now", singer: "Lady A", image: .cover2),
                Song(title: "Wagon Wheel", singer: "Darius Rucker", image: .cover3)
            ]
        ),
        Playlist(
            name: "Hip Hop Beats",
            description: "Feel the rhythm with these hip hop hits.",
            image: .cover3,
            categories: [
                SearchCategory.examples[5],
                SearchCategory.examples[7],
                SearchCategory.examples[0],
            ],
            songs: [
                Song(title: "Sicko Mode", singer: "Travis Scott", image: .cover4),
                Song(title: "God's Plan", singer: "Drake", image: .cover5),
                Song(title: "HUMBLE.", singer: "Kendrick Lamar", image: .cover1),
                Song(title: "Old Town Road", singer: "Lil Nas X", image: .cover1),
                Song(title: "Mo Bamba", singer: "Sheck Wes", image: .cover2),
                Song(title: "Suge", singer: "DaBaby", image: .cover3),
                Song(title: "Lucid Dreams", singer: "Juice WRLD", image: .cover4)
            ]
        ),
    ]
}
