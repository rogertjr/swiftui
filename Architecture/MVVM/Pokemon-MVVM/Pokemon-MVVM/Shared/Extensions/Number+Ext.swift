//
//  Number+Ext.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import Foundation

// MARK: - Int
extension Int {
    /// Divides a integer by a float and return a float number as a result
    func divide(by divisor: Float) -> Float {
        let float = Float(self)
        let result = float / divisor
        return result
    }
}

// MARK: - Float
extension Float {
    /// Removes decimal places if it's not necessary and return a string as a result
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
