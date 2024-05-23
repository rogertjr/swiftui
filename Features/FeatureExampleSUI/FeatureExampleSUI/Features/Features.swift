//
//  Features.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import Foundation

enum Features: String, CaseIterable {
    case grid
    case charts
    
    var description: String {
        return self.rawValue.capitalized
    }
    
    var iconName: String {
        switch self {
        case .grid:
            return "square.grid.3x2"
        case .charts:
            return "chart.pie"
        }
    }
}
