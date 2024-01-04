//
//  Item.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/3/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    @Attribute(.unique) var id = UUID()
    @Attribute(.externalStorage) var imageData: Data?
    var category: ItemCategory?
    var name: String
    var location: String
    var purchaseDate: Date
    var dateAdded: Date
    var purchasePrice: Decimal
    var currentValue: Decimal
    var quantity: Int
    var condition: Condition
    var notes: String
    var tag: String
    var inUse: Bool
    var archieve: Bool

    init(name: String, location: String, purchaseDate: Date, purchasePrice: Decimal, dateAdded: Date, currentValue: Decimal, quantity: Int, condition: Condition, notes: String,tag: String, inUse: Bool, archieve: Bool, imageData: Data?) {
        self.name = name
        self.location = location
        self.purchaseDate = purchaseDate
        self.purchasePrice = purchasePrice
        self.dateAdded = dateAdded
        self.currentValue = currentValue
        self.quantity = quantity
        self.condition = condition
        self.notes = notes
        self.tag = tag
        self.inUse = inUse
        self.archieve = archieve
        self.imageData = imageData ?? nil
    }
}

extension Item {
    enum Condition: String, CaseIterable, Codable {
        case one = "Poor"
        case two = "Not Great"
        case three = "Lived With"
        case four = "Gently Used"
        case five = "Like New"
        case six = "New In Box"
        case seven = "Broken"
    }
}
