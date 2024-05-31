//
//  RadioShow.swift
//  AppleMusic
//
//  Created by Daniil (work) on 13.05.2024.
//

import SwiftUI

struct RadioShow: Identifiable {
    let id = UUID()
    let tag: RadioShowTag
    let name: String
    let shortSummary: String?
    let image: ImageResource
}

extension RadioShow: AppContent {
    var title: String {
        name
    }
    
    var subtitle: String? {
        shortSummary
    }
    
    var secondaryTitle: String {
        tag.rawValue
    }

    var description: String? {
        nil
    }
}

extension RadioShow {
    static let examples: [RadioShow] = [RadioShow(tag: .new,
                                                  name: "Музыкальное шоу с Вилли Вонкой",
                                                  shortSummary: nil,
                                                  image: .cover1),
                                        RadioShow(tag: .exclusive,
                                                  name: "Музыкальное шоу с Вилли Вонкой",
                                                  shortSummary: "Это то, что точно стоит услышать.",
                                                  image: .cover2),
                                        RadioShow(tag: .favourite,
                                                  name: "Музыкальное шоу с Вилли Вонкой",
                                                  shortSummary: "Это то, что точно стоит услышать.",
                                                  image: .cover3),
                                        RadioShow(tag: .favourite,
                                                  name: "Музыкальное шоу с Вилли Вонкой",
                                                  shortSummary: "Это то, что точно стоит услышать.",
                                                  image: .cover4),
                                        RadioShow(tag: .favourite,
                                                  name: "Музыкальное шоу с Вилли Вонкой",
                                                  shortSummary: "Это то, что точно стоит услышать.",
                                                  image: .cover5),]
}
