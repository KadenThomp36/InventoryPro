//
//  InventoryProApp.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/3/24.
//

import SwiftData
import SwiftUI

@main
struct InventoryProApp: App {
    @StateObject private var session = SessionManager()

    var sharedModelContainer: ModelContainer = {
        do {
            let schema = Schema([
                Profile.self,
                Session.self,
                Location.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainAppView()
                .environmentObject(session)
        }
        .modelContainer(sharedModelContainer)
    }
}
