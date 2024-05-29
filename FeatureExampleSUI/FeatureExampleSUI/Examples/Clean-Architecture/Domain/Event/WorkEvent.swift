//
//  WorkEvent.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 29/05/24.
//

import Foundation
import SwiftData

@Model
class WorkEvent {
    var id: UUID
    var title: String
    var subtitle: String
    var date: Date
    
    init(id: UUID = UUID(), title: String, subtitle: String, date: Date) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.date = date
    }
}
