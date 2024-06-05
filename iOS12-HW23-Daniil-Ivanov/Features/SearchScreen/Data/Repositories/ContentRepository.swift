//
//  ContentRepository.swift
//  AppleMusic
//
//  Created by Daniil (work) on 05.06.2024.
//

import Foundation

protocol ContentRepository {
    func fetchContent() async -> [AnyAppContent]
}

final class ContentRepositoryImpl: ContentRepository {
    private let dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    func fetchContent() async -> [AnyAppContent] {
        await dataSource.fetchContent()
    }
}
