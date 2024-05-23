//
//  CoinRowView.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

struct CoinRowView: View {
    // MARK: - Properties
    let coin: Coin
    @Binding var isLoading: Bool
    
    // MARK: - Layout
    var body: some View {
        HStack {
            Text(coin.marketCapRank.toRankString())
                .font(.caption)
                .foregroundStyle(.gray)
                        
            VStack(alignment: .center) {
                if let url = URL(string: coin.image) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .ignoresSafeArea(.all)
                                .clipShape(Circle())
                        } placeholder: {
                            Image(systemName: "bitcoinsign.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .redacted(reason: isLoading ? .placeholder : [])
                                .animatePlaceholder(isLoading: $isLoading)
                        }
                } else {
                    Image(systemName: "number.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.orange)
                }
            }
            .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.subheadline.bold())
                    .padding(.leading, 4)
                
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.leading, 6)
            }
            .padding(.leading, 2)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(coin.currentPrice.toCurrencyString())
                    .font(.subheadline.bold())
                    .padding(.leading, 4)
                
                Text(coin.priceChangePercentage24H.toPercentString())
                    .font(.caption)
                    .foregroundStyle(coin.priceChangePercentage24H > 0 ? .green : .red)
                    .padding(.leading, 6)
            }
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .animatePlaceholder(isLoading: $isLoading)
    }
}

// MARK: - Preview
#Preview {
    var coins: [Coin] {
        let coinsResult = try! JSONMapper.decode(MockResultFiles.coinList.rawValue, 
                                                 type: [Coin].self)
        return coinsResult
    }
    
    return VStack {
        CoinRowView(coin: coins.first!, isLoading: .constant(true))
        CoinRowView(coin: coins.first!, isLoading: .constant(false))
    }
    .padding(.horizontal)
    .previewLayout(.sizeThatFits)
}
