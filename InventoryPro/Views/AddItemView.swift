//
//  AddItemView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/4/24.
//

import Combine
import SwiftData
import SwiftUI

struct AddItemView: View {
    @State private var category: String = ""
    @State private var isInputAlertShown = false

    @State private var name: String = ""
    @State private var itemCategory: ItemCategory?
    @State private var location: String = ""
    @State private var purchaseDate: Date = .init()
    @State private var purchasePrice: String = ""
    @State private var currentValue: String = ""
    @State private var quantity: Int = 1
    @State private var condition: Item.Condition = .six
    @State private var notes: String = ""
    @State private var tag: String = ""

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \ItemCategory.name) private var categories: [ItemCategory]
    // @State private var image: Data

    let range = 1 ... 50

    var body: some View {
        NavigationSplitView {
            VStack {
                Form {
                    Section(header: Text("Purchase Information")) {
                        TextField("Name", text: $name)
                        TextField("Location", text: $location)
                        DatePicker("Purchase Date",
                                   selection: $purchaseDate,
                                   displayedComponents: [.date])
                        // TextField("Purchase Price", text: $purchasePrice)
                    }
                    Section(header: Text("Catagorize")) {
                        HStack {
                            Picker("Category", selection: $itemCategory) {
                                Text("Select a category").tag(ItemCategory(name: "Uncategorized"))
                                ForEach(categories) { category in
                                    Text(category.name).tag(category as ItemCategory?)
                                }
                            }
                            Spacer()
                            Button("+") {
                                isInputAlertShown = true
                            }
                            .padding(.leading)
                            .font(.title)
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        Picker(selection: $condition, label: Text("Condition")) {
                            ForEach(Item.Condition.allCases, id: \.self) { condition in
                                Text(condition.rawValue).tag(condition)
                            }
                        }
                        NavigationLink {
                            AddCategoryView()
                                .navigationTitle("Add Category")
                        } label: {
                            Text("Add Category")
                        }
                    }
                    Section(header: Text("Details")) {
                        Stepper(
                            value: $quantity,
                            in: range
                        ) {
                            Text("Quantity: \(quantity)x") // make this a text field instead
                        }
                        TextField("Purchase Price:", text: $purchasePrice)
                            .keyboardType(.numberPad)
                            .onReceive(Just(purchasePrice)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.purchasePrice = filtered
                                }
                            }
                        TextField("Current Value", text: $currentValue)
                            .keyboardType(.numberPad)
                            .onReceive(Just(currentValue)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.currentValue = filtered
                                }
                            }
                        TextField("name", text: $name)
                        TextField("name", text: $name)
                        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                        addItem()
                        dismiss()
                    }) {
                        Text("Save")
                    }
                }
            }
        } detail: { // research what this does
            Text("Select an item")
        }
        .alert("Add New Category", isPresented: $isInputAlertShown) {
            TextField("Enter Job Title", text: $category)
                .textInputAutocapitalization(.words)
            Button("Add", action: addCategory)
            Button("Cancel", role: .cancel) {}
        }
    }

    private func addCategory() {
        withAnimation {
            let newCat = ItemCategory(
                name: category,
                icon: "folder.badge.questionmark"
            )
            modelContext.insert(newCat)
            category = ""
        }
        try? modelContext.save()
    }

    private func addItem() {
        if itemCategory == nil {
            category = "Uncategorized"
            itemCategory = ItemCategory(name: category)
            addCategory()
        }

        withAnimation {
            let currentDate = Date()
            let newItem = Item(
                name: self.name,
                location: self.location,
                purchaseDate: self.purchaseDate,
                purchasePrice: toDouble(stringValue: self.purchasePrice),
                dateAdded: currentDate,
                currentValue: toDouble(stringValue: self.currentValue),
                quantity: 1,
                condition: Item.Condition.six,
                notes: "Use it occassionally",
                tag: "this is a tag",
                inUse: true,
                archieve: false,
                category: itemCategory!,
                imageData: nil
            )
            modelContext.insert(newItem)
        }
        try? modelContext.save()
    }

    private func toDouble(stringValue: String) -> Double {
        if let doubleValue = Double(stringValue) {
            // Successfully casted to double, you can use doubleValue
            return doubleValue
        } else {
            // Unable to cast to double, handle the error or provide a default value
            return 0.0
        }
    }
}

#Preview {
    AddItemView()
        .modelContainer(for: ItemCategory.self, inMemory: false)
}

// self.name = name
// self.category = category
// self.location = location
// self.purchaseDate = purchaseDate
// self.purchasePrice = purchasePrice
// self.dateAdded = dateAdded
// self.currentValue = currentValue
// self.quantity = quantity
// self.condition = condition
// self.notes = notes
// self.tag = tag
// self.imageData = imageData ?? nil
