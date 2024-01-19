//
//  CategoryListView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/5/24.
//

import SwiftData
import SwiftUI

struct CategoryListView: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var categories: [ItemCategory]

    var body: some View {
        List {
            ForEach(categories) { category in
                Section(header: Text("\(category.name)")
                    .font(.title)
                    .fontWeight(.black))
                {
                    NavigationLink {
                        ItemList(itemCategoryName: category.name)
                            .navigationTitle(category.name)
                    } label: {
                        CategoryLinkView(itemCategory: category)
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {}
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
