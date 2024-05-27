//
//  Recipe.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 24/05/24.
//

import SwiftUI
import SwiftData

enum Category: String, CaseIterable {
    case income = "Income"
    case expense = "Expense"
}

let appTint: Color = .blue

struct TintColor: Identifiable {
    let id: UUID = .init()
    var color: String
    var value: Color
    
    static var tints: [TintColor] = [
        .init(color: "Red", value: .red),
        .init(color: "Blue", value: .blue),
        .init(color: "Pink", value: .pink),
        .init(color: "Purple", value: .purple),
        .init(color: "Brown", value: .brown),
        .init(color: "Orange", value: .orange)
    ]
}

@Model
class Transaction {
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    @Transient
    var color: Color {
        return TintColor.tints.first(where: { $0.color == tintColor })?.value ?? appTint
    }
    
    @Transient
    var tint: TintColor? {
        return TintColor.tints.first(where: { $0.color == tintColor })
    }
    
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue})
    }
}
