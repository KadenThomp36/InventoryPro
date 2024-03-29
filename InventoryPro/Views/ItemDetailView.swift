//
//  ItemDetailView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/7/24.
//

import SwiftUI

struct ItemDetailView: View {
    var item: Item
    var body: some View {
        ScrollView {
            HStack {
                Text("\(item.category.name)")
                    .font(.title)
                    .padding()
                Spacer()
            }

            Text("Purchased on \(item.purchaseDate, format: Date.FormatStyle(date: .abbreviated, time: .omitted))")

            Text("Located in \(item.location)")
            Text("Added on \(item.dateAdded, format: Date.FormatStyle(date: .numeric, time: .standard))")
            Text("It's in \(item.condition.rawValue) condition")
            Text("\(item.notes)")
        }
    }
}

#Preview {
    let date = Date()
    let cat = ItemCategory(name: "Tech", icon: "folder.badge.questionmark")
    let newItem = Item(name: "PS5", location: "Bedroom", purchaseDate: date, purchasePrice: 50.0, dateAdded: date, currentValue: 50.0, quantity: 5, condition: Item.Condition.five, notes: "Good stuff", tag: "electronic", inUse: true, archieve: false, category: cat, imageData: nil)
    return ItemDetailView(item: newItem)
}
