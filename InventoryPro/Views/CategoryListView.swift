//
//  CategoryListView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/5/24.
//

import SwiftUI
import SwiftData

struct CategoryListView: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var categories: [ItemCategory]

    var body: some View {
        List {
            ForEach(categories) { category in
                NavigationLink {
                    ItemList(itemCategoryName: category.name)
                        .navigationTitle(category.name)
                } label: {
                    Text(category.name)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                
            }
            ToolbarTitleMenu()
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(categories[index])
            }
        }
    }
}

#Preview {
    CategoryListView()
}
