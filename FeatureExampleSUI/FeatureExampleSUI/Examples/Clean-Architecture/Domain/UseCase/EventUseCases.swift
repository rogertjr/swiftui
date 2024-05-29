//
//  EventUseCases.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 29/05/24.
//

import Foundation

struct EventUseCases: EventRepository {
    var repo: EventRepository
    
    mutating func getEvents() -> [WorkEvent] {
        return repo.getEvents()
    }
    
    func createEvent(event: WorkEvent) -> WorkEvent? {
        return repo.createEvent(event: event)
    }
}
