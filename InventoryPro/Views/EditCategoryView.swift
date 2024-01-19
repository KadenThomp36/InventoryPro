//
//  EditCategoryView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/15/24.
//

import SwiftData
import SwiftUI

struct EditCategoryView: View {
    @Query private var categories: [ItemCategory]

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationView {
            VStack {
                //            Button(action: {
                //                //addCategory()
                //                //dismiss()
                //                //isInputAlertShown = true
                //            }) {
                //                Label("Add", systemImage: "plus")
                //            }

                List {
                    NavigationLink {
                        AddCategoryView()
                            .navigationTitle("Add Category")
                    } label: {
                        Text("Add Category")
                    }
                    ForEach(categories) { cat in
                        Text("\(cat.name)")
                    }
                    .onDelete(perform: deleteItems)
                }
                Spacer()
            }
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
    EditCategoryView()
}
