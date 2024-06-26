//
//  TransactionCardView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 24/05/24.
//

import SwiftUI
import SwiftData

struct TransactionCardView: View {
    // MARK: - Properties
    @Environment(\.modelContext) private var modelContext
    var transaction: Transaction
    var showCategory: Bool = false
    var showData: Bool
    
    // MARK: - Layout
    var body: some View {
        SwipeAction(cornerRadius: 10, direction: .trailing) {
            HStack(spacing: 12) {
                Text("\(String(transaction.title.prefix(1)))")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(transaction.color.gradient, in: .circle)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(transaction.title)
                        .foregroundStyle(.primary)
                    
                    Text(transaction.remarks)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(transaction.category == Category.income.rawValue ? Color.green.gradient : Color.red.gradient, in: .capsule)
                    
                    Text(format(transaction.dateAdded, style: .medium))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(currencyString(transaction.amount, maxDigits: 2))
                    .fontWeight(.semibold)
                    .redacted(reason: showData ? [] : .placeholder)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.background, in: .rect(cornerRadius: 10))
        } actions: {
            Action(tint: .red, icon: "trash") {
                modelContext.delete(transaction)
            }
        }
    }
}

// MARK: - Preview
#Preview {
        let container = try! ModelContainer(for: Transaction.self,
                                            configurations: .init(for: Transaction.self, isStoredInMemoryOnly: true))

        let transaction = Transaction(title: "AirPods",
                                      remarks: "Apple Product",
                                      amount: .zero,
                                      dateAdded: .now,
                                      category: .expense,
                                      tintColor: .init(color: "Red", value: .red))
        container.mainContext.insert(transaction)
        
        return TransactionCardView(transaction: transaction, showData: true)
            .modelContainer(container)
            .previewLayout(.sizeThatFits)
}
