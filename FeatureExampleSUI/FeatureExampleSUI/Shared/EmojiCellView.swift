//
//  EmojiCellView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI

struct EmojiCellView: View {
    // MARK: - Properties
    let emoji: Emoji
    
    // MARK: - UI Elements
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(UIColor.systemGroupedBackground))
            Text(emoji.emojiString)
                .font(.system(size: 40))
                .padding()
        }
    }
}

// MARK: - Preview Provider
#Preview {
    EmojiCellView(emoji: Emoji.exampleData().first!)
        .previewLayout(.sizeThatFits)
}
