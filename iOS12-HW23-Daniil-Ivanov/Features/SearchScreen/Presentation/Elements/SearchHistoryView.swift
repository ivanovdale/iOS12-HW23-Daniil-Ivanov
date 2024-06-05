//
//  SearchHistoryView.swift
//  AppleMusic
//
//  Created by Daniil (work) on 04.06.2024.
//

import SwiftUI

struct SearchHistoryView: View {
   let searchHistory: [AnyAppContent]
   let onClearButtonTapped: () -> Void

   var body: some View {
       VStack(spacing: 0) {
           HStack(spacing: 0) {
               Text("Недавние поиски")
               Spacer()
               Button("Очистить", action: onClearButtonTapped)
           }
           .font(.callout)
           .fontWeight(.semibold)
           Divider()
               .padding(.top, 8)
           ContentPreviewView(
               content: searchHistory,
               // Open content
               onContentTapped: { _ in }
           )
       }
       .padding(.top, 16)
   }
}
