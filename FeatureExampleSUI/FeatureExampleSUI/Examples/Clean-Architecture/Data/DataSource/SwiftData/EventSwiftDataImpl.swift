//
//  EventSwiftDataImpl.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 29/05/24.
//

import SwiftUI
import SwiftData

struct EventSwiftDataImpl: EventRepository {
    @Environment(\.modelContext) private var context
    @Query(animation: .snappy) private var events: [WorkEvent]
    
    mutating func getEvents() -> [WorkEvent] {
        _events = Query(sort: [SortDescriptor(\WorkEvent.date, order: .reverse)],
                              animation: .snappy)
        return events
    }
    
    func createEvent(event: WorkEvent) -> WorkEvent? {
        context.insert(event)
        return event
    }
}
