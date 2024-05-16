//
//  StatisticView.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

struct StatisticView: View {
    // MARK: - Properties
    let model: StatisticModel
    
    // MARK: - Layout
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.title)
                .font(.caption)
            
            Text(model.value)
                .font(.headline)
            
            
            if let percentChange = model.percentageChange {
                HStack(spacing: 4) {
                    Image(systemName: percentChange > 0 ? "triangle.fill": "arrowtriangle.down.fill")
                        .font(.caption)
                    
                    Text(percentChange.toPercentString())
                        .font(.caption.bold())
                }
                .foregroundColor(percentChange > 0 ? .green : .red)
            }
        }
    }
}

#Preview {
    StatisticView(model: StatisticModel(title: "Preview", 
                                        value: "N/a",
                                        percentageChange: nil))

}
