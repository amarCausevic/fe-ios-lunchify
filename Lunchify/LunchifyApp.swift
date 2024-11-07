//
//  LunchifyApp.swift
//  Lunchify
//
//  Created by Amar Causevic on 17. 10. 24.
//

import SwiftUI
import SwiftData

@main
struct LunchifyApp: App {
    var sharedModelContainer: ModelContainer = {
        let controller = UserController()

        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            controller.getUser()
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
    
   
}
