//
//  LibraryView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 11.05.2024.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(alignment: .center) {
                    Text("Ищете свою музыку?")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Здесь появится купленная Вами в iTunes Store музыка.")
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .padding(.horizontal, geometry.size.width * 0.1)
                        .multilineTextAlignment(.center)
                }
                .navigationTitle("Медиатека")
            }
        }
    }
}
