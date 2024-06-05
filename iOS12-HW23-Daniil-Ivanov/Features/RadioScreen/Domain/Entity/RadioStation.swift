//
//  RadioStation.swift
//  AppleMusic
//
//  Created by Daniil (work) on 13.05.2024.
//

import SwiftUI

struct RadioStation: Identifiable {
    let id = UUID()
    let name: String
    let shortSummary: String
    let image: ImageResource
}

extension RadioStation: Equatable {
    static func ==(lhs: RadioStation, rhs: RadioStation) -> Bool {
        lhs.id == rhs.id
    }
}

extension RadioStation {
    static let examples = [RadioStation(name: "Популярное",
                                        shortSummary: "То, что слушают прямо сейчас.",
                                        image: .cover1),
                           RadioStation(name: "Музыка для расслабления",
                                        shortSummary: "Электронная медитация.",
                                        image: .cover2),
                           RadioStation(name: "Классика",
                                        shortSummary: "То, что слушают прямо сейчас.",
                                        image: .cover3),
                           RadioStation(name: "Популярное",
                                        shortSummary: "То, что слушают прямо сейчас.",
                                        image: .cover4),
                           RadioStation(name: "Популярное",
                                        shortSummary: "То, что слушают прямо сейчас.",
                                        image: .cover5),]
}
