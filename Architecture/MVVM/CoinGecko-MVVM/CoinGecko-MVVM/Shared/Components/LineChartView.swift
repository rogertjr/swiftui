//
//  LineChartView.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI
import Charts

struct LineChartView: View {
    // MARK: - Properties
    let viewModel: CoinDetailsViewModel
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Layout
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart {
                Plot {
                    ForEach(viewModel.chartData) { item in
                        LineMark(x: .value("Date", item.date), y: .value("Price", item.value))
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(viewModel.chartLineColor)
                        
//                        AreaMark(x: .value("Date", item.date),
//                                 y: .value("Price", item.value))
//                            
//                            .foregroundStyle(
//                                .linearGradient(colors: [viewModel.chartLineColor.opacity(0.8),
//                                                        colorScheme == .dark ? .black : .white],
//                                                startPoint: .top, endPoint: .bottom))
//                            .opacity(0.8)
                            
                    }
                }
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 2))
            }
            .chartXScale(domain: ClosedRange(uncheckedBounds: (lower: viewModel.startDate,
                                                               upper: viewModel.endDate)))
            
            .chartXAxis {
                AxisMarks(position: .bottom, values: viewModel.xAxisValues) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel() {
                        if let dateValue = value.as(Date.self) {
                            Text(dateValue.asShortDateString())
                        }
                    }
                }
            }
            .chartYScale(domain: ClosedRange(uncheckedBounds: (lower: viewModel.minPrice,
                                                               upper: viewModel.maxPrice)))
            .chartYAxis {
                AxisMarks(position: .leading, values: viewModel.yAxisValues) { value in
                    AxisGridLine()
                    AxisValueLabel() {
                        if let doubleValue = value.as(Double.self) {
                            Text(doubleValue.formattedWithAbbreviations())
                        }
                    }
                }
            }
        } else {
            Text("Chart unavailable :(")
                .font(.title2)
                .bold()
        }
    }
}

#Preview {
    var coins: [Coin] {
        let coinsResult = try! JSONMapper.decode(MockResultFiles.coinList.rawValue, type: [Coin].self)
        return coinsResult
    }
    
    return LineChartView(viewModel: CoinDetailsViewModel(coins.first!))
        .frame(height: 250)
        .previewLayout(.sizeThatFits)
}
