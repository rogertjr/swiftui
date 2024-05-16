//
//  CoinDetailsView.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

struct CoinDetailsView: View {
    enum ChartStyle: String, CaseIterable, Identifiable {
        var id: Self { return self }
        case bar, line
    }
    
    // MARK: - Properties
    let coin: Coin
    private let viewModel: CoinDetailsViewModel
    @State private var selectedType: ChartStyle = .line
    
    // MARK: - Init
    init(_ coin: Coin) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coin)
    }
    
    // MARK: - Layout
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Picker(selection: $selectedType) {
                    ForEach(ChartStyle.allCases) { style in
                        Text(style.rawValue)
                    }
                } label: {
                    Text("Chart Style")
                }
                .pickerStyle(.segmented)

                switch selectedType {
                case .bar:
                    BarChartView(viewModel: viewModel)
                        .frame(height: 250)
                        .padding(.vertical)
                case .line:
                    LineChartView(viewModel: viewModel)
                        .frame(height: 250)
                        .padding(.vertical)
                }
                
                CoinDetailSectionView(model: viewModel.overviewSectionModel)
                    .padding(.vertical)
                
                CoinDetailSectionView(model: viewModel.additionalDetailsSectionModel)
                    .padding(.vertical)
            }
        }
        .padding()
        .navigationTitle(viewModel.coinName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                coinToolbarLogo
            })
        }
    }
}

// MARK: - ViewBuilders
private extension CoinDetailsView {
    var coinToolbarLogo: some View {
        HStack {
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Theme.textColor.opacity(0.5))
            
            VStack(alignment: .center) {
                if let url = URL(string: coin.image) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .ignoresSafeArea(.all)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                } else {
                    Image(systemName: "number.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.orange)
                }
            }
            .frame(width: 25, height: 25)
        }
    }
}

#Preview {
    var coins: [Coin] {
        let coinsResult = try! JSONMapper.decode(MockResultFiles.coinList.rawValue,
                                                 type: [Coin].self)
        return coinsResult
    }
    
    return NavigationView {
        CoinDetailsView(coins.first!)
    }
    .navigationTitle(coins.first!.name)
}
