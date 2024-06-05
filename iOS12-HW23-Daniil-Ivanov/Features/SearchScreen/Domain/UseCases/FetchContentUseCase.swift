//
//  FetchContentUseCase.swift
//  AppleMusic
//
//  Created by Daniil (work) on 05.06.2024.
//

import Foundation

protocol FetchContentUseCase {
    func fetchContent() async -> [AnyAppContent]
}

final class FetchContentInteractor: FetchContentUseCase {
    private let contentRepository: ContentRepository

    init(contentRepository: ContentRepository) {
        self.contentRepository = contentRepository
    }

    func fetchContent() async -> [AnyAppContent] {
        await contentRepository.fetchContent()
    }
}
