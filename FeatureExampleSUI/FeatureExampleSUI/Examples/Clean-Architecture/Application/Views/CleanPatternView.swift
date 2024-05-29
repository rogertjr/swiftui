//
//  CleanPatternView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 29/05/24.
//

#warning("Fix `missing` modelContext crash")
// https://www.hackingwithswift.com/quick-start/swiftdata/common-swiftdata-errors-and-their-solutions

import SwiftUI
import SwiftData

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
