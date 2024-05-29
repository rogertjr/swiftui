//
//  CleanPatternView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 29/05/24.
//

import SwiftUI
import SwiftData

// Domain/Event/Entity.swift
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

// Domain/Repository/EventRepository.swift
protocol EventRepository {
    mutating func getEvents() -> [WorkEvent]
    func createEvent(event: WorkEvent) -> WorkEvent?
}

// Domain/UseCase/EventUseCases.swift
struct EventUseCases: EventRepository {
    var repo: EventRepository
    
    mutating func getEvents() -> [WorkEvent] {
        return repo.getEvents()
    }
    
    func createEvent(event: WorkEvent) -> WorkEvent? {
        return repo.createEvent(event: event)
    }
}

// Data/DataSource/SwiftData/EventSwiftDataImpl.swift
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

// Data/Repository/EventRepositoryImpl.swift
struct EventRepositoryImpl: EventRepository {
    var dataSource: EventRepository
    
    mutating func getEvents() -> [WorkEvent] {
        return dataSource.getEvents()
    }
    
    func createEvent(event: WorkEvent) -> WorkEvent? {
        return dataSource.createEvent(event: event)
    }
}

// Application/ViewModels/EventListViewModel.swift
class EventListViewModel: ObservableObject {
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

struct CleanPatternView: View {
    @StateObject var viewModel = EventListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.events) { event in
                VStack (alignment: .leading, spacing: 4) {
                    Text(event.title)
                    Text(event.date.formatted())
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                Button("Add") { viewModel.createEvent() }
                    .tint(.primary)
            }
            .task {
                viewModel.getEvents()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let container = try! ModelContainer(for: WorkEvent.self,
                                        configurations: .init(for: WorkEvent.self, isStoredInMemoryOnly: false))
    let event = WorkEvent(title: "Pet Grooming",
                          subtitle: "A day dedicated to pet grooming",
                          date: .now)
    container.mainContext.insert(event)
    
    return NavigationStack {
        CleanPatternView()
            .preferredColorScheme(.dark)
    }
    .modelContainer(container)
}
