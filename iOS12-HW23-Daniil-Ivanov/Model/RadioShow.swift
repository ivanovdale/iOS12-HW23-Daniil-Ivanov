//
//  RadioShow.swift
//  AppleMusic
//
//  Created by Daniil (work) on 13.05.2024.
//

import Foundation

struct RadioShow: Identifiable {
    let id = UUID()
    let tag: RadioShowTag
    let name: String
    let shortSummary: String?
    let imageName: String
}

extension RadioShow {
    static let examples: [RadioShow] = [RadioShow(tag: .new,
                                                  name: "Музыкальное шоу с Вилли Вонкой",
                                                  shortSummary: nil,
                                                  imageName: "Cover1"),
                                        RadioShow(tag: .exclusive,
                                                  name: "Музыкальное шоу с Вилли Вонкой",
                                                  shortSummary: "Это то, что точно стоит услышать.",
                                                  imageName: "Cover2"),
                                        RadioShow(tag: .favourite,
                                                  name: "Музыкальное шоу с Вилли Вонкой",
                                                  shortSummary: "Это то, что точно стоит услышать.",
                                                  imageName: "Cover3"),
                                        RadioShow(tag: .favourite,
                                                  name: "Музыкальное шоу с Вилли Вонкой",
                                                  shortSummary: "Это то, что точно стоит услышать.",
                                                  imageName: "Cover4"),
                                        RadioShow(tag: .favourite,
                                                  name: "Музыкальное шоу с Вилли Вонкой",
                                                  shortSummary: "Это то, что точно стоит услышать.",
                                                  imageName: "Cover5"),]
}
