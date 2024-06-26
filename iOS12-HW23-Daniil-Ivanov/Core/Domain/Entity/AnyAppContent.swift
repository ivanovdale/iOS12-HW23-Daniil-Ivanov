//
//  AnyAppContent.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct AnyAppContent: AppContent {
    private let _id: () -> UUID
    private let _title: () -> String
    private let _subtitle: () -> String?
    private let _secondaryTitle: () -> String
    private let _description: () -> String?
    private let _image: () -> ImageResource
    private let _type: () -> String
    private let _isDownloaded: () -> Bool

    var id: UUID { _id() }
    var title: String { _title() }
    var subtitle: String? { _subtitle() }
    var secondaryTitle: String { _secondaryTitle() }
    var description: String? { _description() }
    var image: ImageResource { _image() }
    var type: String { _type() }
    var isDownloaded: Bool { _isDownloaded() }

    init<C: AppContent>(_ content: C) {
        _id = { content.id }
        _title = { content.title }
        _subtitle = { content.subtitle }
        _secondaryTitle = { content.secondaryTitle }
        _description = { content.description }
        _image = { content.image }
        _type = { content.type }
        _isDownloaded = { content.isDownloaded }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension AnyAppContent {
    static func == (lhs: AnyAppContent, rhs: AnyAppContent) -> Bool {
        lhs.id == rhs.id
    }
}
