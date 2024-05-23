//
//  LazyVGridView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI

struct LazyVGridView: View {
    // MARK: - Properties
    let emojiList = Emoji.exampleData()
    let gridColumns = [GridItem(.adaptive(minimum: 80))]
    
    // MARK: - UI Elements
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns) {
                ForEach(emojiList) { emoji in
                    EmojiCellView(emoji: emoji)
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview Provider
#Preview {
    LazyVGridView()
}
