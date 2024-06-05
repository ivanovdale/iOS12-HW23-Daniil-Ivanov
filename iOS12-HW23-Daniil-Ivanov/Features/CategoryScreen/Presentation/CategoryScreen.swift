//
//  CategoryScreen.swift
//  AppleMusic
//
//  Created by Daniil (work) on 31.05.2024.
//

import SwiftUI

struct CategoryScreen: View {

    let category: SearchCategory

    @Environment(\.colorScheme)
    var colorScheme

    @Environment(\.dismiss)
    var dismiss

    @Environment(PlayerParameters.self)
    var playerParameters

    @State
    var playlists: [Playlist] = []

    @State
    var albums: [Album] = []

    @State
    var allContent: [AnyAppContent] = []

    @GestureState
    private var dragOffset = CGSize.zero



    var body: some View {
        GeometryReader { proxy in
            let contentTotalPadding = Metric.padding * 3
            let smallSectionHeight = proxy.size.height * 0.4
            let smallSectionContentWidth = proxy.size.width * 0.55 - contentTotalPadding

            ScrollView(.vertical) {
                VStack(alignment: .leading,spacing: 0) {
                    Divider()
                        .padding(Metric.padding)

                    AppContentSectionView(
                        height: proxy.size.height * 0.6,
                        contentWidth: proxy.size.width - contentTotalPadding,
                        content: allContent,
                        leadingPadding: CategoryScreen.Metric.padding,
                        mode: .big
                    )

                    Divider()
                        .padding(Metric.padding)

                    AppContentSectionView(
                        title: "Плейлисты",
                        height: smallSectionHeight,
                        contentWidth: smallSectionContentWidth,
                        content: playlists,
                        leadingPadding: Metric.padding,
                        mode: .small
                    ).padding(.bottom, 16)

                    AppContentSectionView(
                        title: "Альбомы",
                        height: smallSectionHeight,
                        contentWidth: smallSectionContentWidth,
                        content: albums,
                        leadingPadding: Metric.padding,
                        mode: .small
                    )

                    Color.clear.frame(height: playerParameters.height)

                }
            }
            .navigationTitle(category.name)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.red)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.red)
                            .frame(width: 30, height: 30)
                            .background(Color(uiColor: colorScheme == .dark ? .darkGray : .systemGray6))
                            .clipShape(Circle())
                    })
                }
            }
            .onAppear {
                loadContents()
            }
            .gesture(
                // Fixing swipe back gesture
                DragGesture()
                    .updating(
                        $dragOffset,
                        body: { (value, state, transaction) in
                            if value.startLocation.x < 20 && value.translation.width > 100 {
                                dismiss()
                            }
                        }
                    )
            )


        }
    }

    private func loadContents() {
        playlists = Playlist.examples
            .filter { $0.categories.contains(category) }
        let typeErasedPlaylists = playlists.map { AnyAppContent($0) }

        albums = Album.examples
            .filter { $0.categories.contains(category) }
        let typeErasedAlbums = albums.map { AnyAppContent($0) }

        allContent = (typeErasedPlaylists + typeErasedAlbums)
                    .sorted(by: { $0.title < $1.title })
    }

    // MARK: - Constants
    enum Metric {
        static let padding = 16.0
    }
}

private struct AppContentSectionView<Content: AppContent>: View {
    let title: String?
    let height: CGFloat
    let contentWidth: CGFloat
    let content: [Content]
    let leadingPadding: CGFloat
    let mode: AppContentDisplayMode

    init(
        title: String? = nil,
        height: CGFloat,
        contentWidth: CGFloat,
        content: [Content],
        leadingPadding: CGFloat,
        mode: AppContentDisplayMode
    ) {
        self.title = title
        self.height = height
        self.contentWidth = contentWidth
        self.content = content
        self.leadingPadding = leadingPadding
        self.mode = mode
    }

    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
            }

            AppContentListView(
                height: height,
                contentWidth: contentWidth,
                content: content,
                spacing: nil,
                leadingPadding: leadingPadding,
                mode: mode
            )
            .padding(.bottom, 16)
        }
    }
}



#Preview {
    NavigationStack {
        CategoryScreen(category: SearchCategory.examples.first!)
    }
}
