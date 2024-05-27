//
//  ChartsView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI


struct ChartsView: View {
    // MARK: - Properties
    private enum ChartType: String, CaseIterable {
        case bar, multi, heat, pie
    }

    @State private var selectedType: ChartType = .bar
    
    // MARK: - UI Elements
    var body: some View {
        ScrollView {
            VStack {
                Picker("Type of chart to preview", selection: $selectedType) {
                    ForEach(ChartType.allCases, id: \.self) {
                        Text($0.rawValue.capitalized).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                
                Divider()
                    .padding(.vertical)
                
                switch selectedType {
                case .bar:
                    BarChartsView()
                case .multi:
                    MultipleDataSeriesChartView()
                case .heat:
                    HeatChartView()
                case .pie:
                    PieChartView()
                }
            }
        }
        .toolbarRole(.editor)
    }
}

// MARK: -
#Preview {
    NavigationStack {
        ChartsView()
    }
}
