//
//  AddTransactionTip.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 27/05/24.
//

import Foundation
import TipKit

struct AddTransactionTip: Tip {
    @Parameter
    static var showTip: Bool = false
    static var numberOfTimesVisited: Event = Event(id: "xyz.swiftui.tip.event.numberoftimesvisited")
    
    var title: Text {
        Text("Try to add a transaction")
    }
    
    var message: Text? {
        Text("You can add an item by tapping on the plus icon")
    }
    
    var asset: Image? {
        Image(systemName: "lightbulb")
    }
    
    var options: [TipOption] {
        return [
            // Indicated the number of times that the tip will be present before be invalidated
            Tips.MaxDisplayCount(2)
        ]
    }
    
    var rules: [Rule] {
        return [#Rule(Self.$showTip) { $0 == true }]
    }
}

