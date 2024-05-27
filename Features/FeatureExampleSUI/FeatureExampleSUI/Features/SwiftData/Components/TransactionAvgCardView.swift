//
//  CardView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 24/05/24.
//

import SwiftUI

struct TransactionAvgCardView: View {
    // MARK: - Properties
    var income: Double
    var expense: Double
    var show: Bool
    private var total: Double { income - expense }
    
    // MARK: - Layout
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
            
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Text("\(currencyString(total, maxDigits: 2))")
                        .font(.title.bold())
                        .foregroundStyle(Color.primary)
                        .redacted(reason: show ? [] : .placeholder)
                    
                    Image(systemName: expense > income ? "chart.line.downtrend.xyaxis" : "chart.line.uptrend.xyaxis")
                        .font(.title3)
                        .foregroundStyle(expense > income ? .red : .green)
                }
                .padding(.bottom, 25)
                
                HStack(spacing: 0) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        let iconImage = category == .income ? "arrow.down" : "arrow.up"
                        let tint: Color = category == .income ? .green : .red
                        
                        HStack(spacing: 10) {
                            Image(systemName: iconImage)
                                .font(.callout.bold())
                                .foregroundStyle(tint)
                                .frame(width: 35, height: 35)
                                .background {
                                    Circle()
                                        .fill(tint.opacity(0.25).gradient)
                                }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                
                                Text(currencyString(category == .income ? income : expense, maxDigits: 0))
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.primary)
                                    .redacted(reason: show ? [] : .placeholder)
                            }
                            
                            if category == .income {
                                Spacer(minLength: 10)
                            }
                        }
                    }
                }
            }
                .padding([.horizontal, .bottom], 25)
                .padding(.top, 15)
        }
    }
}

#Preview {
    ScrollView {
        TransactionAvgCardView(income: 321, expense: 123, show: true)
        
        TransactionAvgCardView(income: 123, expense: 321, show: false)
    }
}
