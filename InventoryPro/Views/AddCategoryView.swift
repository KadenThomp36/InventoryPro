//
//  AddCategoryView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/15/24.
//

import SwiftData
import SwiftUI
import SymbolPicker

struct AddCategoryView: View {
    @State private var iconPickerPresented = false
    @State private var icon = "plus.square.dashed"
    @State private var categoryName: String = ""
    @State private var isInputAlertShown = false

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Form {
            TextField("Category Name", text: $categoryName)
            HStack {
                Spacer()
                Button {
                    iconPickerPresented = true
                } label: {
                    HStack {
                        Image(systemName: icon)
                            .resizable(resizingMode: .stretch)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                    addCategory()

                }) {
                    Text("Save")
                }
            }
        }
        .sheet(isPresented: $iconPickerPresented, content: {
            SymbolPicker(symbol: $icon)
        })

        .alert(isPresented: $isInputAlertShown) {
            Alert(title: Text("All fields must contain values"))
        }
    }

    private func addCategory() {
        if categoryName == "" {
            isInputAlertShown = true
            return
        }
        withAnimation {
            let newCat = ItemCategory(
                name: categoryName,
                icon: icon
            )
            modelContext.insert(newCat)
            categoryName = ""
            try? modelContext.save()
        }
        dismiss()
    }
}

#Preview {
    AddCategoryView()
}
