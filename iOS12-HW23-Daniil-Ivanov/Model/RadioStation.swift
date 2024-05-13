//
//  RadioStation.swift
//  AppleMusic
//
//  Created by Daniil (work) on 13.05.2024.
//

import Foundation

struct RadioStation: Identifiable {
    let id = UUID()
    let name: String
    let shortSummary: String
    let imageName: String
}

extension RadioStation {
    static let examples = [RadioStation(name: "Популярное",
                                        shortSummary: "То, что слушают прямо сейчас.",
                                        imageName: "Cover1"),
                           RadioStation(name: "Музыка для расслабления",
                                        shortSummary: "Электронная медитация.",
                                        imageName: "Cover2"),
                           RadioStation(name: "Классика",
                                        shortSummary: "То, что слушают прямо сейчас.",
                                        imageName: "Cover3"),
                           RadioStation(name: "Популярное",
                                        shortSummary: "То, что слушают прямо сейчас.",
                                        imageName: "Cover4"),
                           RadioStation(name: "Популярное",
                                        shortSummary: "То, что слушают прямо сейчас.",
                                        imageName: "Cover5"),]
}
