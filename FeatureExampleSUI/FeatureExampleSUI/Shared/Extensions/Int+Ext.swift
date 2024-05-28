//
//  Int+Ext.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import Foundation

extension Int {
    func toRankString() -> String {
        return String(format: "#%@", self.description)
    }
}
