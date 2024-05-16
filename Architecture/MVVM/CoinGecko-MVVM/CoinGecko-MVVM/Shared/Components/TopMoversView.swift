//
//  TopMoversView.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

struct TopMoversView: View {
    // MARK: - Properties
    @EnvironmentObject var viewModel: AppViewModel
    
    // MARK: - Layout
    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Movers")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.topMovingCoins) { coin in
                        NavigationLink {
                            CoinDetailsView(coin)
                        } label: {
                            TopMoversItemView(coin: coin)
                                .tint(Theme.textColor)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    TopMoversView()
        .environmentObject(AppViewModel(CoinService()))
}
