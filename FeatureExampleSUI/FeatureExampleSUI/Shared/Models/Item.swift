//
//  Item.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import Foundation

struct Item: Identifiable {
    let id = UUID()
    var item: String
    var description: String
    var quantity: Int = 1
    var price: Double = 0
    
    static func exampleData() -> [Item] {
        return [
            Item(item: "Apple",
                 description: "Juicy green apple",
                 quantity: 3,
                 price: 1.99),
            Item(item: "Orange",
                 description: "Sweet and tangy orange",
                 quantity: 5,
                 price: 2.49),
            Item(item: "Banana",
                 description: "Fresh yellow banana",
                 quantity: 2,
                 price: 0.99)
        ]
    }
}
