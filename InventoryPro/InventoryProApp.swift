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
    var sharedModelContainer: ModelContainer = {
        do {
            let schema = Schema([
                ItemCategory.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .navigationTitle("Categories")
                    .tabItem {
                        Label("Items", systemImage: "book")
                    }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
