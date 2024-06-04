//
//  AppContent.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

protocol AppContent: Identifiable, Equatable, Hashable {
    var id: UUID { get }
    var title: String { get }
    var subtitle: String? { get }
    var secondaryTitle: String { get }
    var description: String? { get }
    var image: ImageResource { get }
    var type: String { get }
    var isDownloaded: Bool { get }
}
