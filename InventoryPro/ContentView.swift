//
//  ContentView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.purchaseDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        Text("name: \(item.name)")
                        Text("name: \(item.category)")
                        Text("name: \(item.location)")
                        Text("name: \(item.dateAdded, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                        Text("name: \(item.purchasePrice)")
//                        Text("name: \(item.currentValue)")
                        Text("name: \(item.quantity)")
                        Text("name: \(item.condition)")
                        Text("name: \(item.notes)")
                        
                    } label: {
                        Text(item.purchaseDate, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let currentDate = Date()
            let newItem = Item(
                name: "PS5", category: "Technology", location: "Bedroom", purchaseDate: currentDate, purchasePrice: 799.99, dateAdded: currentDate, currentValue: 500, quantity: 1, condition: "Like New", notes: "Use it occassionally", imageData: nil
            )
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
