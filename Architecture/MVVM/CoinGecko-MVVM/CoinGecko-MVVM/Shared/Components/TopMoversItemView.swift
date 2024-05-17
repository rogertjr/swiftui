//
//  TopMoversItemView.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

struct TopMoversItemView: View {
    // MARK: - Properties
    let coin: Coin
    @Binding var isLoading: Bool
    
    // MARK: - Layout
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                if let url = URL(string: coin.image) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .ignoresSafeArea(.all)
                            .clipped()
                    } placeholder: {
                        Image(systemName: "number.circle.fill")
                            .redacted(reason: isLoading ? .placeholder : [])
                            .animatePlaceholder(isLoading: $isLoading)
                    }
                } else {
                    Image(systemName: "number.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.orange)
                }
            }
            .frame(width: 32, height: 32)
            .padding(.bottom, 8)
            
            HStack(spacing: 2) {
                Text(coin.symbol.uppercased())
                    .font(.caption.bold())
                
                Text(coin.currentPrice.toCurrencyString())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Text(coin.priceChangePercentage24H.toPercentString())
                .font(.title2)
                .foregroundColor(coin.priceChangePercentage24H > 0 ? .green : .red)
        }
        .frame(width: 140, height: 140)
        .background(Theme.itemBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .redacted(reason: isLoading ? .placeholder : [])
        .animatePlaceholder(isLoading: $isLoading)
    }
}

// MARK: - PreviewProvider
#Preview {
    var coins: [Coin] {
        let coinsResult = try! JSONMapper.decode(MockResultFiles.coinList.rawValue, type: [Coin].self)
        return coinsResult
    }
    
    return HStack {
        TopMoversItemView(coin: coins.first!, isLoading: .constant(true))
        TopMoversItemView(coin: coins.first!, isLoading: .constant(false))
    }
    .previewLayout(.sizeThatFits)
}
