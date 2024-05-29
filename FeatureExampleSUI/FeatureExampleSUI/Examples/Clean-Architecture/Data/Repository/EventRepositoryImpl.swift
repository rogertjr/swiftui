//
//  EventRepositoryImpl.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 29/05/24.
//

import Foundation

struct EventRepositoryImpl: EventRepository {
    var dataSource: EventRepository
    
    mutating func getEvents() -> [WorkEvent] {
        return dataSource.getEvents()
    }
    
    func createEvent(event: WorkEvent) -> WorkEvent? {
        return dataSource.createEvent(event: event)
    }
}
