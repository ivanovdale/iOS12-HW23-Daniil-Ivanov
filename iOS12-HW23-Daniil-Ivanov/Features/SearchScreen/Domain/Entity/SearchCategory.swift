//
//  SearchCategory.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct SearchCategory: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let image: ImageResource
}

extension SearchCategory {
    static let examples = [
        SearchCategory(
            name: "Зимнее время",
            image: .cover1
        ),
        SearchCategory(
            name: "Поп на русском",
            image: .cover2
        ),
        SearchCategory(
            name: "Поп",
            image: .cover3
        ),
        SearchCategory(
            name: "Альтернатива",
            image: .cover4
        ),
        SearchCategory(
            name: "Пространственное звучание",
            image: .cover5
        ),
        SearchCategory(
            name: "Хип-хоп на русском",
            image: .cover1
        ),
        SearchCategory(
            name: "Инстранный рок",
            image: .cover2
        ),
        SearchCategory(
            name: "Хиты",
            image: .cover3
        ),
        SearchCategory(
            name: "90-е",
            image: .cover4
        ),
        SearchCategory(
            name: "Рок",
            image: .cover5
        ),
    ]
}
