//
//  Architecture.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import Foundation

enum Architecture: String, CaseIterable {
    case mvvm
    case mv
    case clean
    
    var description: String { return self.rawValue.uppercased() }
    
    var iconName: String {
        switch self {
        case .mvvm: return "tray.2"
        case .mv: return "tray.full"
        case .clean: return "slowmo"
        }
    }
}
