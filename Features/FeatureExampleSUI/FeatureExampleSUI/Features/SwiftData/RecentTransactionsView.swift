//
//  RecentsView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 24/05/24.
//

import SwiftUI

struct RecentTransactionsView: View {
    // MARK: - Properties
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var selectedCategory: Category = .expense
    @State private var isFiltering: Bool = false
    @State private var showFilterOverlay: Bool = false
    
    // MARK: - UI Elements
    var body: some View {
        ScrollView(.vertical) {
            FilterTransactionView(statDate: startDate, endDate: endDate) { transactions in
                TransactionAvgCardView(income: total(transactions, category: .income),
                                       expense: total(transactions, category: .expense))
                
                pickerView

                Divider()
                    .padding(.horizontal)
                
                ForEach(transactions.filter({ $0.category == selectedCategory.rawValue })) { transaction in
                    NavigationLink(destination: { TransactionView(editTransaction: transaction) },
                                   label: { TransactionCardView(transaction: transaction) })
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("Transactions")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    showFilterOverlay = true
                    isFiltering = true
                }, label: {
                    Image(systemName: isFiltering
                            ? "line.horizontal.3.decrease.circle.fill"
                            : "line.horizontal.3.decrease.circle")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .frame(width: 45, height: 45)
                })
            })
            
            ToolbarItem(placement: .navigationBarTrailing, content: {
                NavigationLink(destination: { TransactionView() }) {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .frame(width: 45, height: 45)
                }
            })
        }
        .blur(radius: showFilterOverlay ? 8 : 0)
        .disabled(showFilterOverlay)
        .overlay {
            if showFilterOverlay {
                DateFilterView(start: startDate, end: endDate, onSubmit: { start, end in
                    startDate = start
                    endDate = end
                    showFilterOverlay = false
                    isFiltering = true
                }, onClose: {
                    startDate = .now.startOfMonth
                    endDate = .now.endOfMonth
                    showFilterOverlay = false
                    isFiltering = false
                })
                .transition(.opacity)
            }
        }
        .animation(.snappy, value: showFilterOverlay)
    }
}

// MARK: - Filter Component
struct DateFilterView: View {
    // MARK: - Properties
    @State var start: Date
    @State var end: Date
    var onSubmit: (Date, Date) -> Void
    var onClose: () -> Void
    
    // MARK: - Layout
    var body: some View {
        VStack(spacing: 15) {
            DatePicker("Start Date", selection: $start, displayedComponents: [.date])
            DatePicker("End Date", selection: $end, displayedComponents: [.date])
            
            HStack(spacing: 15) {
                Button("Cancel") { onClose() }
                    .buttonStyle(.borderless)
                    .buttonBorderShape(.roundedRectangle(radius: 5))
                    .tint(appTint)
                
                Button("Filter") { onSubmit(start, end) }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 5))
                    .tint(appTint)
            }
            .padding(.top, 10)
        }
        .padding(15)
        .background(.bar, in: .rect(cornerRadius: 10))
        .padding(.horizontal, 30)
    }
}

// MARK: - Builders
private extension RecentTransactionsView {
    var pickerView: some View {
        Picker(selection: $selectedCategory) {
            ForEach(Category.allCases, id: \.self) {
                Text($0.rawValue.capitalized)
            }
        } label: { Text("") }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        RecentTransactionsView()
    }
}
