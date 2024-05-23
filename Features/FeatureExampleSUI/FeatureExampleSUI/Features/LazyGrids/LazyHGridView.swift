//
//  LazyHGridView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI

struct LazyHGridView: View {
    // MARK: - Properties
    let emojiList = Emoji.exampleData()
    let gridColumns = Array(repeating: GridItem(.fixed(100)), count: 3)
    
    // MARK: - UI Elements
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridColumns) {
                ForEach(emojiList) { emoji in
                        EmojiCellView(emoji: emoji)
                    }
            }
        }
    }
}

// MARK: - Preview Provider
#Preview {
    LazyHGridView()
}
