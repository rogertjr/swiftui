//
//  BarChartView.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI
import Charts

struct BarChartView: View {
    // MARK: - Properties
    let viewModel: CoinDetailsViewModel
    
    // MARK: - Layout
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart { }
        } else {
            Text("Chart unavailable :(")
                .font(.title2)
                .bold()
        }
    }
}

#Preview {
    var coins: [Coin] {
        let coinsResult = try! JSONMapper.decode(MockResultFiles.coinList.rawValue,
                                                 type: [Coin].self)
        return coinsResult
    }
    return BarChartView(viewModel: CoinDetailsViewModel(coins.first!))
        .previewLayout(.sizeThatFits)
}
