//
//  HeatChartView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI
import Charts

struct HeatChartView: View {
    // MARK: - Properties
    let heatData: [HeatData] = HeatData.exampleData()
    
    // MARK: - UI Elements
    var body: some View {
        ScrollView {
            Chart {
                ForEach(heatData) { data in
                    RectangleMark(xStart: .value("start location x", data.locationX - 25),
                                  xEnd: .value("end location x", data.locationX + 25),
                                  yStart: .value("start location y", data.locationY - 25),
                                  yEnd: .value("end location y", data.locationY + 25))
                    .foregroundStyle(by: .value("Number", data.temperatur))
                }
            }
            .chartXScale(domain: 25...225)
            .chartYScale(domain: 25...225)
            .aspectRatio(1, contentMode: .fit)
            .padding(.horizontal)
        }
        .navigationTitle("Heat Map Chart")
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        HeatChartView()
    }
}
