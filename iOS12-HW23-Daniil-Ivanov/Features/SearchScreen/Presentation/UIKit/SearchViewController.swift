//
//  SearchViewController.swift
//  AppleMusic
//
//  Created by Daniil (work) on 07.06.2024.
//

import UIKit
import Observation

final class SearchViewController: UIViewController {
    private let categories = SearchCategory.examples

    private let playerParameters: PlayerParameters
    private let viewModel: SearchViewModel

    private var searchController: UISearchController?

    // MARK: - Outlets

    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Metric.layoutInteritemSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            SearchCategoryItemCell.self,
            forCellWithReuseIdentifier: SearchCategoryItemCell.identifier
        )
        collectionView.register(
            LabelCollectionViewCell.self,
            forCellWithReuseIdentifier: LabelCollectionViewCell.identifier
        )

        if let playerParameters = viewModel.playerParameters {
            collectionView.contentInset.bottom = playerParameters.height
        }

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Init

    init(playerParameters: PlayerParameters, viewModel: SearchViewModel) {
        self.playerParameters = playerParameters
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayerParamaters()
        setupHierarchy()
        setupLayout()
        setupView()
        setupBindings()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        [categoriesCollectionView].forEach { view.addSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metric.collectionViewPadding),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metric.collectionViewPadding),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupView() {
        view.backgroundColor = .white
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        setupNavigationBarTitle()
        setupNavigationBarSearch()
    }

    private func setupNavigationBarTitle() {
        self.title = "Поиск"
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.barTintColor = UIColor.white
            navigationBar.prefersLargeTitles = true
        }
    }

    private func setupNavigationBarSearch() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.delegate = self
        searchController?.searchBar.placeholder = "Ваша Медиатека"

        self.navigationItem.searchController = searchController

        searchController?.searchBar.scopeButtonTitles = SearchViewModel.SearchScope.allCases.map { $0.rawValue }
        searchController?.scopeBarActivation = .onSearchActivation
    }

    private func setupPlayerParamaters() {
        viewModel.setupPlayerParameters(playerParameters)
    }

    private func setupBindings() {
        withContinousObservation(of: self.viewModel.isSearchInProgress) { [weak self] _ in
            guard let self else { return }
            self.viewModel.updateSearchState()
            self.viewModel.searchInProgressHandler()
        }
    }

    private func withContinousObservation<T>(of value: @escaping @autoclosure () -> T, execute: @escaping (T) -> Void) {
        withObservationTracking {
            execute(value())
        } onChange: {
            DispatchQueue.main.async { [weak self] in
                self?.withContinousObservation(of: value(), execute: execute)
            }
        }
    }
}

// MARK: - Extensions

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            CGSize(width: collectionView.frame.width, height: 30)
        } else {
            CGSize(width: UIScreen.main.bounds.width / 2 
                   - Metric.collectionViewPadding
                   - (Metric.layoutInteritemSpacing / 2), height: 110)
        }
    }
}

// MARK: UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Add one element - LabelCollectionViewCell
        categories.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LabelCollectionViewCell.identifier,
                for: indexPath
            ) as? LabelCollectionViewCell else {
                return UICollectionViewCell()
            }

            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchCategoryItemCell.identifier,
                for: indexPath
            ) as? SearchCategoryItemCell else {
                return UICollectionViewCell()
            }

            // Minus one element - LabelCollectionViewCell
            cell.configure(with: categories[indexPath.item - 1])
            return cell
        }
    }
}

// MARK: UISearchControllerDelegate

extension SearchViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        viewModel.isSearchInProgress = true
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.isSearchInProgress = false
    }
}

fileprivate enum Metric {
    static let collectionViewPadding = 16.0
    static let layoutInteritemSpacing = 10.0
}
