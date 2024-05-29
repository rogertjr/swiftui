//
//  RecentsView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 24/05/24.
//

import SwiftUI

// MARK: - View Extension
private extension View {
    func total(_ transactions: [Transaction], category: Category) -> Double {
        return transactions.filter({ $0.category == category.rawValue }).reduce(Double.zero) { partialResult, transaction in
            return partialResult + transaction.amount
        }
    }
}

struct RecentTransactionsView: View {
    // MARK: - Properties
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var selectedCategory: Category = .expense
    @State private var isFiltering: Bool = false
    @State private var showFilterOverlay: Bool = false
    @State private var searchedText: String = ""
    private var addTransactionTip = AddTransactionTip()
    @AppStorage("ShowData") private var showData = true
    
    // MARK: - UI Elements
    var body: some View {
        ScrollView(.vertical) {
            FilterTransactionView(statDate: startDate, endDate: endDate, searchedText: searchedText) { transactions in
                TransactionAvgCardView(income: total(transactions, category: .income),
                                       expense: total(transactions, category: .expense),
                                       show: showData)
                
                pickerView
                
                Divider()
                    .padding(.horizontal)
                
                if transactions.isEmpty {
                    if !searchedText.isEmpty {
                        ContentUnavailableView.search(text: searchedText)
                    } else {
                        ContentUnavailableView(label: {
                            Label("No transactions where added yet",
                                  systemImage: "dollarsign.square")
                        })
                    }
                } else {
                    ForEach(transactions.filter({ $0.category == selectedCategory.rawValue })) { transaction in
                        NavigationLink(destination: { TransactionView(editTransaction: transaction) },
                                       label: {
                            TransactionCardView(transaction: transaction, showData: showData)
                        })
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .task {
            if !isFiltering && searchedText.isEmpty {
                AddTransactionTip.showTip = true
                await AddTransactionTip.numberOfTimesVisited.donate()
            }
        }
        .navigationTitle("Transactions")
        .searchable(text: $searchedText, placement: .automatic)
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: { showData.toggle() }, label: {
                    Image(systemName: showData
                          ? "eye.slash"
                          : "eye")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(appTint)
                    .frame(width: 45, height: 45)
                })
            })
            
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
                    .foregroundStyle(appTint)
                    .frame(width: 45, height: 45)
                })
            })
            
            ToolbarItem(placement: .navigationBarTrailing, content: {
                NavigationLink(destination: { TransactionView() }) {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(appTint)
                        .frame(width: 45, height: 45)
                        .popoverTip(addTransactionTip, arrowEdge: .top)
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

// MARK: - Components and Builders
private extension RecentTransactionsView {
    struct DateFilterView: View {
        // MARK: - Properties
        @State var start: Date
        @State var end: Date
        var onSubmit: (Date, Date) -> Void
        var onClose: () -> Void
        
        @Environment(\.colorScheme) var colorScheme
        private var buttonColor: Color {
            colorScheme == .dark ? Color.black : Color.white
        }
        
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
                        .foregroundStyle(buttonColor)
                        .tint(appTint)
                }
                .padding(.top, 10)
            }
            .padding(15)
            .background(.bar, in: .rect(cornerRadius: 10))
            .padding(.horizontal, 30)
        }
    }
    
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
