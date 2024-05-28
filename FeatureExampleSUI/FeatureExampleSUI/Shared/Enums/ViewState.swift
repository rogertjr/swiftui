//
//  ViewState.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import Foundation

enum ViewState: Comparable {
    case idle
    case isLoading
    case finishedLoading
    case noResults
    case error(String)
}
