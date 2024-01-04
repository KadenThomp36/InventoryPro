//
//  AddItemView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/4/24.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    @State private var name: String = ""
    @State private var itemCategory: ItemCategory?
    @State private var location: String = ""
    @State private var purchaseDate: Date = Date()
    @State private var purchasePrice: Int = 0
    @State private var currentValue: String = ""
    @State private var quantity: Int = 1
    @State private var condition: Item.Condition = .six
    @State private var notes: String = ""
    @State private var tag: String = ""
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \ItemCategory.name) private var categories: [ItemCategory]
    //@State private var image: Data
    
    let range = 1...50

    var body: some View {
        NavigationSplitView{
            VStack{
                Form {
                    Section(header: Text("Notifications")) {
                        
                        TextField("name", text: $name)
                        TextField("location", text: $location)
                        DatePicker(selection: $purchaseDate, label: { Text("Purchase Date") })
                        
                        
                        // TextField("Purchase Price", text: $purchasePrice)
                        Picker(selection: $condition, label: Text("Condition")) {
                            ForEach(Item.Condition.allCases, id: \.self) { condition in
                                Text(condition.rawValue).tag(condition)
                            }
                        }
                    }
                    Section(header: Text("Notifications")) {
                        Picker("Category", selection: $itemCategory) {
                            Text("Select a category").tag(nil as ItemCategory?)
                            ForEach(categories) { category in
                                Text(category.name).tag(category as ItemCategory?)
                            }
                            d
                        }
                        NavigationLink("Add Category") {
                            AddCategoryView()
                        }
                    }
                        
                    Stepper(
                        value: $quantity,
                        in: range
                    ) {
                        Text("Quantity: \(quantity)x") // make this a text field instead
                    }
                        TextField("name", text: $name)
                        TextField("name", text: $name)
                        TextField("name", text: $name)
                        TextField("name", text: $name)
                        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    
                }
            }
            .toolbar {
                ToolbarItem() {
                    Button(action: {
                        //isShowingSheet.toggle()
                        
                    }) {
                        Text("Save")
                    }
                }
            }
        } detail: { // research what this does
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let currentDate = Date()
            let newItem = Item(
                name: name,
                location: location,
                purchaseDate: purchaseDate,
                purchasePrice: 799.99,
                dateAdded: currentDate,
                currentValue: 500,
                quantity: 1,
                condition: Item.Condition.six,
                notes: "Use it occassionally",
                tag: "this is a tag",
                inUse: true,
                archieve: false,
                imageData: nil
            )
            newItem.category = nil
            modelContext.insert(newItem)
        }
    }
}



struct AddCategoryView: View {
    @State private var category: String = ""
    
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack{
            Text("Add Category")
            TextField("Category", text: $category)
            Button(action: {
                     addCategory()
                 }) {
                     Label("Add Cat", systemImage: "plus")
                 }
        }
    }
    
    private func addCategory() {
        withAnimation {
            let newCat = ItemCategory(
                name: category
            )            
            modelContext.insert(newCat)
        }
    }
}

#Preview {
    AddItemView()
}
//self.name = name
//self.category = category
//self.location = location
//self.purchaseDate = purchaseDate
//self.purchasePrice = purchasePrice
//self.dateAdded = dateAdded
//self.currentValue = currentValue
//self.quantity = quantity
//self.condition = condition
//self.notes = notes
//self.tag = tag
//self.imageData = imageData ?? nil
