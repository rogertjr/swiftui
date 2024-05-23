//
//  ContentView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - UI Elements
    var body: some View {
        List {
            ForEach(Features.allCases, id: \.self) { feat in
                ItemRowView(title: feat.description,
                            icon: feat.iconName,
                            content: { featureView(feat) })
            }
        }
        .navigationTitle("SwiftUI")
    }
}

private extension HomeView {
    func featureView(_ feature: Features) -> some View {
        VStack {
            switch feature {
            case .charts: ChartsView()
            case .grid: GridView()
            }
        }
    }
}

// MARK: - Preview Provider
#Preview {
    NavigationStack {
        HomeView()
    }
}
