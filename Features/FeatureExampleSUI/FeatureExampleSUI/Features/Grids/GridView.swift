//
//  GridView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI

struct GridView: View {
    // MARK: - Properties
    let itemList = Item.exampleData()
    var total: Double {
        itemList.map({ $0.price }).reduce(0, +)
    }
    
    private enum GridType: String, CaseIterable {
        case grid, vLazy, hLazy
        var description: String {
            switch self {
            case .vLazy: return "V Lazy"
            case .hLazy: return "H Lazy"
            default: return self.rawValue.capitalized
            }
        }
    }
    
    @State private var selectedType: GridType = .grid
    
    // MARK: - UI Elements
    var body: some View {
        ScrollView {
            VStack {
                Picker("Type of grid to preview", selection: $selectedType) {
                    ForEach(GridType.allCases, id: \.self) {
                        Text($0.description.capitalized).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Divider()
                    .padding(.vertical)
                
                switch selectedType {
                case .grid:
                    gridView
                case .vLazy:
                    LazyVGridView()
                case .hLazy:
                    LazyHGridView()
                }
            }
        }
        .navigationTitle("Grids")
    }
}

private extension GridView {
    var gridView: some View {
        GroupBox("Receipt") {
            Grid(alignment: .leadingFirstTextBaseline,
                 horizontalSpacing: 5,
                 verticalSpacing: 10) {
                
                // Column Headings
                GridRow {
                    Text("Item")
                    Text("Description")
                    Text("Quantity")
                    Text("Price")
                }
                .font(.title3)
                
                // Divider to separate headings from items
                Divider()
                
                // Item Rows
                ForEach(itemList) { item in
                    GridRow {
                        Text(item.item)
                            .bold()
                        Text(item.description)
                        Text("Qty: \(item.quantity)")
                        Text(String(format: "$%.2f", item.price))
                    }
                }
                
                // Divider to separate items from total
                Divider()
                
                // Total
                GridRow {
                    Text("Total")
                        .bold()
                    Color.clear
                        .gridCellColumns(2)
                        .gridCellUnsizedAxes(.vertical)
                    Text(String(format: "$%.2f", total))
                        .bold()
                }
                
            }
             .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        GridView()
    }
}
