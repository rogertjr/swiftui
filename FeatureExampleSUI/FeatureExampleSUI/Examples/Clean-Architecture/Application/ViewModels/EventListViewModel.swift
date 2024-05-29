//
//  EventListViewModel.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 29/05/24.
//

import SwiftUI
import Combine

final class EventListViewModel: ObservableObject {
    var eventUseCases = EventUseCases(repo: EventRepositoryImpl(dataSource: EventSwiftDataImpl()))
    
    @Published var events: [WorkEvent] = []
    @Published var title = "Pet Grooming"
    @Published var description = "A day dedicated to pet grooming"
    @Published var date: Date = .now
    
    func getEvents() {
        self.events = eventUseCases.getEvents()
    }
    
    func createEvent() {
        let newEvent = WorkEvent(title: title, subtitle: description, date: date)
        guard let event = eventUseCases.createEvent(event: newEvent) else {
            return
        }
        
        withAnimation { events.append(event) }
        resetForm()
    }
    
    func resetForm() {
        self.title = ""
        self.description = ""
        self.date = .now
    }
}
