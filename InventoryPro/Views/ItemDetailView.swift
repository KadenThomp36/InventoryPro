//
//  ItemDetailView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/7/24.
//

import SwiftUI

struct ItemDetailView: View {
    var pass: Pass
    var body: some View {
        ScrollView {
            HStack {
                Text("\(pass.session?.startTime ?? Date(), format: Date.FormatStyle(date: .abbreviated, time: .omitted))")
                    .font(.title)
                    .padding()
                Spacer()
            }

//            Text("Purchased on \(item.purchaseDate, format: Date.FormatStyle(date: .abbreviated, time: .omitted))")
//
//            Text("Located in \(item.location)")
//            Text("Added on \(item.dateAdded, format: Date.FormatStyle(date: .numeric, time: .standard))")
//            Text("It's in \(item.condition.rawValue) condition")
//            Text("\(item.notes)")
        }
    }
}

//#Preview {
//    let date = Date()
//    let cat = Session(name: "Tech", icon: "folder.badge.questionmark")
//    let tag = [ItemTag(name: "Green")]
//    let newItem = Pass(name: "PS5", location: "Bedroom", purchaseDate: date, purchasePrice: 50.0, dateAdded: date, currentValue: 50.0, quantity: 5, condition: Pass.Condition.five, notes: "Good stuff", inUse: true, archieve: false, imageData: nil)
//    newItem.session = cat
//    return ItemDetailView(item: newItem)
//}
