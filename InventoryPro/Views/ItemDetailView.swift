//
//  NavigationDetailView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/7/24.
//

import SwiftUI

struct ItemDetailView: View {
var item: Item
    var body: some View {
        VStack {
            Text("Item at \(item.purchaseDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
            Text("name: \(item.name)")
            Text("name: \(item.category?.name ?? "no cat")")
            Text("name: \(item.location)")
            Text("name: \(item.dateAdded, format: Date.FormatStyle(date: .numeric, time: .standard))")
            Text("name: \(item.quantity)")
            Text("name: \(item.condition.rawValue)")
            Text("name: \(item.notes)")
        }
    }
}

//#Preview {
//    var date = Date()
//    var newItem = Item(name: "PS5", location: "Bedroom", purchaseDate: date, purchasePrice: 50.0, dateAdded: date, currentValue: 50.0, quantity: 5, condition: Item.Condition.five, notes: "Good stuff", tag: "electronic", inUse: true, archieve: false, imageData: nil)
//    ItemDetailView(item: newItem)
//}
