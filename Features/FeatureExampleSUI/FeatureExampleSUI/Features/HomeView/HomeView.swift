//
//  ContentView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    // MARK: - UI Elements
    var body: some View {
        NavigationStack {        
            List {
                ForEach(Features.allCases, id: \.self) { feat in
                    ItemRowView(title: feat.description,
                                icon: feat.iconName,
                                content: { featureView(feat) })
                }
            }
            .navigationTitle("SwiftUI")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: { isOnboarding = true }, label: {
                        Image(systemName: "info.circle")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(appTint)
                            .frame(width: 45, height: 45)
                    })
                })
            }
        }
        .tint(appTint)
        .foregroundStyle(appTint)
    }
}

private extension HomeView {
    func featureView(_ feature: Features) -> some View {
        VStack {
            switch feature {
            case .charts: ChartsView()
            case .grid: GridView()
            case .buttons: ButtonsView()
            case .controls: ControlsView()
            case .swiftData: RecentTransactionsView()
            }
        }
    }
}

// MARK: - Preview Provider
#Preview {
    NavigationStack {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
