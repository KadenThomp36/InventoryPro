//
//  ItemListView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/5/24.
//

import SwiftData
import SwiftUI

struct ItemListView: View {
    let itemCategoryName: String?

    var body: some View {
        if let itemCategoryName {
            ItemList(itemCategoryName: itemCategoryName)
        } else {
            ContentUnavailableView("Select a category", systemImage: "sidebar.left")
        }
    }
}

struct ItemList: View {
    let itemCategoryName: String

    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var isShowingSheet = false

    init(itemCategoryName: String) {
        var predicate: Predicate<Item>
        self.itemCategoryName = itemCategoryName

        predicate = #Predicate<Item> { item in
            item.category.name == itemCategoryName
        }

        _items = Query(filter: predicate, sort: \Item.name)
    }

    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    ItemDetailView(item: item)
                        .navigationTitle(item.name)
                } label: {
                    ItemLinkView(item: item)
                }
            }
            .onDelete(perform: deleteItems)
            .listRowSeparator(.hidden)
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
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview("Selected Category") {
    ItemListView(itemCategoryName: nil)
}
