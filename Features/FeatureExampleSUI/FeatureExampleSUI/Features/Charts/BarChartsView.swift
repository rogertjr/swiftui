//
//  ChartsView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI
import Charts

struct BarChartsView: View {
    // MARK: - Properties
    let data = ChartData.exampleData()
    var maxChartData: ChartData? {
        data.max { $0.count < $1.count }
    }
    var avegareChartData: Int {
        data.map({ $0.count }).reduce(0, +) / data.count
    }
    
    // MARK: - UI Elements
    var body: some View {
        ScrollView {
            VStack {
                barChartOneView
                
                Divider()
                    .padding(.vertical)
                
                barChartTwoView
            }
            .padding(.horizontal)
        }
        .navigationTitle("Bar Charts")
    }
}

private extension BarChartsView {
    var barChartOneView: some View {
        Chart {
            ForEach(data) { dataPoint in
                BarMark(x: .value("Type", dataPoint.type),
                        y: .value("Population", dataPoint.count))
                .opacity(maxChartData == dataPoint ? 1 : 0.5)
                .foregroundStyle(maxChartData == dataPoint ? Color.accentColor : Color.gray)
            }
            
            RuleMark(y: .value("Average", avegareChartData))
                .foregroundStyle(.gray)
                .annotation(position: .bottom,
                            alignment: .bottomLeading) {
                    Text("average \(avegareChartData)")
                        .foregroundColor(.accentColor)
                }
        }
        .frame(height: 250)
    }
    
    var barChartTwoView: some View {
        Chart(data) { dataPoint in
            BarMark(x: .value("Population", dataPoint.count),
                    y: .value("Type", dataPoint.type))
            .foregroundStyle(by: .value("Type", dataPoint.type))
            .annotation(position: .trailing) {
                Text(String(dataPoint.count))
                    .foregroundColor(.gray)
            }
        }
        .frame(height: 250)
        .chartLegend(.hidden)
        .chartYAxis {
            AxisMarks { _ in
                AxisValueLabel()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        BarChartsView()
    }
}
