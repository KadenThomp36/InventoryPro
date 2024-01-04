//
//  Item.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/3/24.
//id: Unique identifier for each item (integer, auto-incrementing primary key)
//name: Name or description of the item (text)
//category: Category or type of item (text)
//location: Physical location of the item (text)
//purchase_date: Date of purchase (date)
//purchase_price: Original purchase price (decimal)
//current_value: Estimated current value (decimal, optional)
//quantity: Number of units of the item (integer, default 1)
//condition: Condition of the item (text, optional, e.g., "new", "used", "good", "fair", "poor")
//notes: Additional notes or details about the item (text, optional)
//image: Photo or image of the item (binary data, optional)

import Foundation
import SwiftData

@Model
final class Item {
    @Attribute(.unique) let id = UUID()
    let name: String
    let category: String
    let location: String
    let purchaseDate: Date
    let dateAdded: Date
    let purchasePrice: Decimal
    let currentValue: Decimal
    let quantity: Int
    let condition: String
    let notes: String
    @Attribute(.externalStorage) var imageData: Data?
    
    init(name: String, category: String, location: String, purchaseDate: Date, purchasePrice: Decimal, dateAdded: Date, currentValue: Decimal, quantity: Int, condition: String, notes: String, imageData: Data?) {
        self.name = name
        self.category = category
        self.location = location
        self.purchaseDate = purchaseDate
        self.purchasePrice = purchasePrice
        self.dateAdded = dateAdded
        self.currentValue = currentValue
        self.quantity = quantity
        self.condition = condition
        self.notes = notes
        self.imageData = imageData ?? nil
    }
}
