//
//  FeatureExampleSUIApp.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI
import SwiftData
import TipKit

@main
struct FeatureExampleSUIApp: App {
    // MARK: - Properties
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var sharedModelContainer: ModelContainer = {
        let transactionConfig = ModelConfiguration(for: Transaction.self, isStoredInMemoryOnly: true)
        let workEventConfig = ModelConfiguration(for: WorkEvent.self)
        
        do {
            return try ModelContainer(for: Transaction.self, WorkEvent.self,
                                      configurations: transactionConfig, workEventConfig)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // MARK: - Init
    init() {
        try? Tips.configure()
    }

    // MARK: - Layout
    var body: some Scene {
        WindowGroup {
            Group {
                if isOnboarding {
                    OnboardingView()
                } else {
                    HomeView()
                }
            }
            .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
}
