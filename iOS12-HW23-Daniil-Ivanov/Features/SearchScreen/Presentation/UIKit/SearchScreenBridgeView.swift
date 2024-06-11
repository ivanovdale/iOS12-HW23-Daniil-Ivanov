//
//  SearchScreenBridge.swift
//  AppleMusic
//
//  Created by Daniil (work) on 07.06.2024.
//

import SwiftUI
import UIKit

struct SearchScreenBridgeView: UIViewControllerRepresentable {
    @Environment(PlayerParameters.self)
    private var playerParameters

    func makeUIViewController(context: Context) -> UIViewController {
        let dataSource = MockDataSource()
        let contentRepository = ContentRepositoryImpl(dataSource: dataSource)
        let fetchContentInteractor = FetchContentInteractor(contentRepository: contentRepository)
        let searchInteractor = SearchInteractor(fetchContentInteractor: fetchContentInteractor)
        let viewModel = SearchViewModel(searchInteractor: searchInteractor)
        let searchViewController = SearchViewController(playerParameters: playerParameters, viewModel: viewModel)

        let navigationController = UINavigationController(rootViewController: searchViewController)
        return navigationController    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
