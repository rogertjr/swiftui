//
//  AllCoinsView.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

struct AllCoinsView: View {
    // MARK: - Properties
    @EnvironmentObject var viewModel: AppViewModel
    private let columns = [GridItem(.flexible())]
    
    // MARK: - Layout
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Coins")
                .font(.headline)
                .padding(.bottom)
            
            HStack {
                Text("Coin")
                
                Spacer()
                
                Text("Prices")
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            gridView
        }
        .padding(.horizontal)
    }
}

// MARK: - ViewBuilder
private extension AllCoinsView {
    @ViewBuilder
    var gridView: some View {
        if let searchedCoins = viewModel.searchedCoins, searchedCoins.count > 0 {
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(searchedCoins, id: \.symbol) { coin in
                    NavigationLink {
                        CoinDetailsView(coin)
                    } label: {
                        CoinRowView(coin: coin)
                            .tint(Theme.textColor)
                    }
                    .buttonStyle(.plain)
                }
            }
        } else {
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(viewModel.coins, id: \.symbol) { coin in
                    NavigationLink {
                        CoinDetailsView(coin)
                    } label: {
                        CoinRowView(coin: coin)
                            .tint(Theme.textColor)
                            .task {
                                if viewModel.hasReachedEnd(of: coin) && !viewModel.isLoading {
                                    await viewModel.fetchNextPage()
                                }
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

// MARK: - PreviewProvider
#Preview {
    AllCoinsView()
        .environmentObject(AppViewModel(CoinService()))
}
