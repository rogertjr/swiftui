//
//  PieChartView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI
import Charts

struct PieChartView: View {
    // MARK: - Properties
    var catTotal: Double {
        catData.reduce(0) { $0 + $1.population }
    }
    var dogTotal: Double {
        dogData.reduce(0) { $0 + $1.population }
    }
    
    var data: [(type: String, amount: Double)] {
        [(type: "cat", amount: catTotal),
         (type: "dog", amount: dogTotal)
        ]
    }
    
    var maxPet: String? {
        data.max { $0.amount < $1.amount }?.type
    }

    // MARK: - UI Elements
    var body: some View {
        ScrollView {
            VStack {
                Chart(data, id: \.type) { dataItem in
                    SectorMark(angle: .value("Type", dataItem.amount),
                               innerRadius: .ratio(0.5),
                               angularInset: 1.5)
                    .cornerRadius(5)
                    .opacity(dataItem.type == maxPet ? 1 : 0.5)
                    .foregroundStyle(by: .value("Type", dataItem.type))
                }
                .frame(height: 250)
                .padding(.horizontal)
            }
        }
        .navigationTitle("Pie Chart")
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PieChartView()
    }
}
