//
//  EventRepository.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 29/05/24.
//

import Foundation

protocol EventRepository {
    mutating func getEvents() -> [WorkEvent]
    func createEvent(event: WorkEvent) -> WorkEvent?
}
