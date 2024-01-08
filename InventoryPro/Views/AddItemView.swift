//
//  AddItemView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/4/24.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    @State private var category: String = ""
    @State private var isInputAlertShown = false
    
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
    @Environment(\.dismiss) private var dismiss
    
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
                        DatePicker("Purchase Date",
                                   selection: $purchaseDate,
                                   displayedComponents: [.date])
                        
                        
                        // TextField("Purchase Price", text: $purchasePrice)
                        Picker(selection: $condition, label: Text("Condition")) {
                            ForEach(Item.Condition.allCases, id: \.self) { condition in
                                Text(condition.rawValue).tag(condition)
                            }
                        }
                    }
                    Section(header: Text("Notifications")) {
                        HStack{
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
                        HStack {

//                            .padding(.trailing, 40.0)

    
                            NavigationLink {
                                EditCategoryView()
                                    .navigationTitle("Edit Categories")
                            } label: {
                                Text("Edit Categories")
                            }
      
                        }
                        .buttonStyle(BorderlessButtonStyle())
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
            Button("Cancel", role: .cancel) { }
        }
        
    }
    
    private func addCategory() {
        withAnimation {
            let newCat = ItemCategory(
                name: category
            )
            modelContext.insert(newCat)
            category = ""
        }
    }
    
    private func addItem() {
        let uncat = ItemCategory(name: "Uncategorized")
        modelContext.insert(uncat)
        
        withAnimation {
            let currentDate = Date()
            let newItem = Item(
                name: self.name,
                location: self.location,
                purchaseDate: self.purchaseDate,
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
            newItem.category = itemCategory
            print(newItem.location)
            print(newItem.category)
            modelContext.insert(newItem)
        }
    }
}



struct EditCategoryView: View {
    
    
    @Query private var categories: [ItemCategory]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack{
//            Button(action: {
//                //addCategory()
//                //dismiss()
//                //isInputAlertShown = true
//            }) {
//                Label("Add", systemImage: "plus")
//            }
            
            List {
                ForEach(categories) { cat in
                    Text("\(cat.name)")
                }
                .onDelete(perform: deleteItems)
            }
            Spacer()
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
    AddItemView()
        .modelContainer(for: ItemCategory.self, inMemory: false)
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
