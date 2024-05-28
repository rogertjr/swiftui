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
        let schema = Schema([Transaction.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
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
