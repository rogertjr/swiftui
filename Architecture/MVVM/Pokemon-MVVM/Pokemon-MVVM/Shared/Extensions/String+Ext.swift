//
//  String+Ext.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import Foundation

extension String {
    /// Verifies if string contains any character
    var isEmpty: Bool {
        self == ""
    }
    
    /// Removes specific string containing within a string
    func remove(_ values: [String]) -> String {
        var stringValue = self
        let toRemove = stringValue.filter { values.contains("\($0)") }
        
        for value in toRemove {
            if let range = stringValue.range(of: "\(value)") {
                stringValue.removeSubrange(range)
            }
        }
        return stringValue
    }
    
    /// Removes \n from string
    func preventNewLines() -> String {
        return self.replacingOccurrences(of: "\n", with: " ", options: .regularExpression)
    }
}
