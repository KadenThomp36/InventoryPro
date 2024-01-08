//
//  CategoryLinkView.swift
//  InventoryPro
//
//  Created by Thompson, Kaden on 1/8/24.
//

import SwiftUI

struct CategoryLinkView: View {
    var category: ItemCategory
    var body: some View {
        HStack{
            VStack {
                Image(systemName: "cloud.sun.rain.fill")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 100, height: 100)
                Text("50 Items")
            }
            
            VStack {
                Spacer()
                
                Text("Total Purchase Value:")
                Text("$12,000")
                Spacer()

                Text("Est. Resale Value:")
                Text("$6,000")
                Spacer()
            }
        }
    }
    
    private func dataAggregator(){
        
    }
}

#Preview {
    var cat = ItemCategory(name: "Apple")
    return CategoryLinkView(category: cat)
}
