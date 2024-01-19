//
//  ItemCategory.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/4/24.
//

import Foundation
import SwiftData

@Model
final class ItemCategory {
    @Attribute(.unique) var name: String

    // `.cascade` tells SwiftData to delete all animals contained in the
    // category when deleting it.
    @Relationship(deleteRule: .cascade, inverse: \Item.category)
    var items: [Item]? = []
    var icon: String

    init(name: String, icon: String = "plus.square.dashed") {
        self.name = name
        self.icon = icon
    }
}
