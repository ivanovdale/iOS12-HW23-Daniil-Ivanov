//
//  SearchUseCase.swift
//  AppleMusic
//
//  Created by Daniil (work) on 05.06.2024.
//

import Foundation

protocol SearchUseCase {
    func loadContent() async
    func searchContent(query: String) async -> [AnyAppContent]
}

final class SearchInteractor: SearchUseCase {
    private let fetchContentInteractor: FetchContentUseCase

    private var allContentList: [AnyAppContent] = []

    init(fetchContentInteractor: FetchContentUseCase) {
        self.fetchContentInteractor = fetchContentInteractor
    }

    func loadContent() async {
        allContentList = await fetchContentInteractor.fetchContent()
    }

    func searchContent(query: String) async -> [AnyAppContent] {
        allContentList.filter { $0.title.lowercased().hasPrefix(query) }
    }
}
