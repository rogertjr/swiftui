//
//  FilterTransactionView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 24/05/24.
//

import SwiftUI
import SwiftData

struct FilterTransactionView<Content: View>: View {
    // MARK: - Properties
    @Query(animation: .snappy) private var transactions: [Transaction]
    var content: ([Transaction]) -> Content
    
    // MARK: - Init
    init(statDate: Date, endDate: Date, searchedText: String, @ViewBuilder content: @escaping ([Transaction]) -> Content) {
        let predicate = #Predicate<Transaction> { transaction in
            return (searchedText == "" ? true : (transaction.title.localizedStandardContains(searchedText)
                                                 || transaction.remarks.localizedStandardContains(searchedText)))
                && transaction.dateAdded >= statDate && transaction.dateAdded <= endDate
        }
        
        _transactions = Query(filter: predicate, 
                              sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], 
                              animation: .snappy)
        
        self.content = content
    }
    
    // MARK: - UI Elements
    var body: some View {
        content(transactions)
    }
}
