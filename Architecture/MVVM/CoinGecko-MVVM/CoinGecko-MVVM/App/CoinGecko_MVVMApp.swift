//
//  CoinGecko_MVVMApp.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

@main
struct CoinGecko_MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .tint(Theme.textColor)
        }
    }
}
