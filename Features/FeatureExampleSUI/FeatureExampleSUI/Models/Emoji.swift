//
//  Emoji.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import Foundation

struct Emoji: Identifiable {
    let value: Int
    
    var emojiString: String {
        guard let scalar = UnicodeScalar(value) else { return "?" }
        return String(Character(scalar))
    }
    
    var id: Int {
        return value
    }
    
    static func exampleData() -> [Emoji] {
        let values = 0x1f600...0x1f64f
        return values.map { Emoji(value: $0) }
    }
}
