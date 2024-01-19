//
//  ItemLinkView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/8/24.
//

import SwiftUI

struct ItemLinkView: View {
    var item: Item
    var body: some View {
        VStack {
            HStack {
                Text("\(item.quantity)")
                Text("\(item.name)")

                Spacer()
            }
            .font(.headline)
            HStack {
                Text("\(item.condition.rawValue)")
                Spacer()
                Text("$\(item.purchasePrice, specifier: "%.2f")")
                Spacer()
                Text("\(item.purchaseDate, format: Date.FormatStyle(date: .abbreviated, time: .omitted))")
                Spacer()
            }
        }
    }
}

#Preview {
    let date = Date()
    let cat = ItemCategory(name: "Tech", icon: "folder.badge.questionmark")
    let newItem = Item(name: "PS5", location: "Bedroom", purchaseDate: date, purchasePrice: 50.0, dateAdded: date, currentValue: 50.0, quantity: 5, condition: Item.Condition.five, notes: "Good stuff", tag: "electronic", inUse: true, archieve: false, category: cat, imageData: nil)
    return ItemLinkView(item: newItem)
}
