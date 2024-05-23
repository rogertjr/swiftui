//
//  MultipleDataSeriesChartView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI
import Charts

struct MultipleDataSeriesChartView: View {
    // MARK: - Properties
    var data: [PetDataSeries] {
        [PetDataSeries(type: "cat", petData: catData),
         PetDataSeries(type: "dog", petData: dogData)]
    }
    
    let linearGradient = LinearGradient(
        gradient: Gradient(colors: [Color.accentColor.opacity(0.4), Color.accentColor.opacity(0)]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    // MARK: - UI Elements
    var body: some View {
        ScrollView {
            VStack {
                multipleSetDataView
                
                Divider()
                    .padding(.vertical)
                
                linearGradientSingleView
            }
            .padding(.horizontal)
        }
        .navigationTitle("Line Chart")
        
    }
}

private extension MultipleDataSeriesChartView {
    var multipleSetDataView: some View {
        Chart(data, id: \.type) { dataSeries in
            ForEach(dataSeries.petData) { data in
                LineMark(x: .value("Year", data.year),
                         y: .value("Population", data.population))
            }
            .foregroundStyle(by: .value("Pet type", dataSeries.type))
            .symbol(by: .value("Pet type", dataSeries.type))
        }
        .frame(height: 250)
        .chartXScale(domain: 1998...2024)
        .aspectRatio(1, contentMode: .fit)
    }
    
    var linearGradientSingleView: some View {
        Chart {
            ForEach(catData) { data in
                LineMark(x: .value("Year", data.year),
                         y: .value("Population", data.population))
            }
            .interpolationMethod(.cardinal)
            .symbol(by: .value("Pet type", "cat"))
            
            ForEach(catData) { data in
                AreaMark(x: .value("Year", data.year),
                         y: .value("Population", data.population))
            }
            .interpolationMethod(.cardinal)
            .foregroundStyle(linearGradient)
        }
        .frame(height: 250)
        .chartXScale(domain: 1998...2024)
        .chartLegend(.hidden)
        .aspectRatio(1, contentMode: .fit)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        MultipleDataSeriesChartView()
    }
}
