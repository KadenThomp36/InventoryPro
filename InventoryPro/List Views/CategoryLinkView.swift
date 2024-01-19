//
//  CategoryLinkView.swift
//  InventoryPro
//
//  Created by Thompson, Kaden on 1/8/24.
//

import SwiftData
import SwiftUI

struct CategoryLinkView: View {

    var itemCategory: ItemCategory

    var body: some View {
        HStack {
            VStack {
                Image(systemName: itemCategory.icon)
                    .resizable(resizingMode: .stretch)
                    .frame(width: 100, height: 100)
                Text("\(itemCategory.items?.count ?? 0)")
            }

            VStack {
                Spacer()

                Text("Total Purchase Value:")
                Text( itemCategory.items?.lazy.map(\.purchasePrice).reduce(0) { $0 + Double($1) } ?? 0.0, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                Spacer()

                Text("Est. Resale Value:")
                Text("$6,000")
                Spacer()
            }
        }
    }

    private func dataAggregator() {}
}

#Preview {
    let cat = ItemCategory(name: "Apple")
    return CategoryLinkView(itemCategory: cat)
}
