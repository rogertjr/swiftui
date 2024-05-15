//
//  Pokemon_MVVMApp.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import SwiftUI

@main
struct Pokemon_MVVMApp: App {
    
    @Namespace var animation
    var body: some Scene {
        WindowGroup {
            PokemonListView(animation: animation)
        }
    }
}
