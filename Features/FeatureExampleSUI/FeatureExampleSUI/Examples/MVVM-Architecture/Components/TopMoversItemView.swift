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
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                if let url = URL(string: coin.image) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .ignoresSafeArea(.all)
//                            .clipped()
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
                    Image(systemName: "bitcoinsign.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Theme.textColor)
                }
            }
            .frame(width: 36, height: 36)
            .padding(.bottom, 8)
            
            HStack(spacing: 2) {
                Text(coin.symbol.uppercased())
                    .font(.caption.bold())
                
                Text(coin.currentPrice.toCurrencyString())
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Text(coin.priceChangePercentage24H.toPercentString())
                .font(.title3)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.3)
                .foregroundStyle(coin.priceChangePercentage24H > 0 ? .green : .red)
                .padding(.horizontal)
        }
        .frame(width: 128, height: 128)
        .background(Theme.itemBackground)
        .redacted(reason: isLoading ? .placeholder : [])
        .animatePlaceholder(isLoading: $isLoading)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
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
