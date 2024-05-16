//
//  CoinDetailSectionView.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

struct CoinDetailSectionView: View {
    // MARK: - Properties
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    let model: CoinDetailsSectionModel
    
    // MARK: - Layout
    var body: some View {
        VStack {
            Text(model.title)
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                ForEach(model.stats) { stat in
                    StatisticView(model: stat)
                }
            }
        }
    }
}

#Preview {
    CoinDetailSectionView(model: CoinDetailsSectionModel(title: "Preview", stats: []))
}
