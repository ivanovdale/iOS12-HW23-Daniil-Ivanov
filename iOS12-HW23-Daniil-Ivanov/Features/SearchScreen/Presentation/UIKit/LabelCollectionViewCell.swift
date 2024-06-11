//
//  LabelCollectionViewCell.swift
//  AppleMusic
//
//  Created by Daniil (work) on 11.06.2024.
//

import UIKit

final class LabelCollectionViewCell: UICollectionViewCell {
    static let identifier = "LabelCollectionViewCell"

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Поиск по категориям"
        label.font = UIFont.boldSystemFont(ofSize: 22)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
