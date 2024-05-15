//
//  Color+Ext.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import UIKit

extension UIColor {
    /// Init with HEX string under 6 characters
    convenience init?(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).remove(["#"])
        guard let hexNumber = UInt32(hexString, radix: 16),
              hexString.count <= 6 else { return nil }
        
        let divisor = CGFloat(255)
        let red = CGFloat((hexNumber & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hexNumber & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hexNumber & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
