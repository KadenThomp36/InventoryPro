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
    @State private var isShowingSheet = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.purchaseDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        Text("name: \(item.name)")
                        Text("name: \(item.category?.name ?? "")")
                        Text("name: \(item.location)")
                        Text("name: \(item.dateAdded, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                        Text("name: \(item.purchasePrice)")
//                        Text("name: \(item.currentValue)")
                        Text("name: \(item.quantity)")
                        Text("name: \(item.condition.rawValue)")
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
                    Button(action: {
                        isShowingSheet.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $isShowingSheet, content: {
                        AddItemView()
                    })
                }
            }
        } detail: {
            Text("Select an item")
        }
        .onAppear {
            print(URL.applicationSupportDirectory.path(percentEncoded: false))
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
        .modelContainer(for: Item.self, inMemory: false)
}

