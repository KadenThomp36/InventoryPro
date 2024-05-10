//
//  Item.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/3/24.
//

import Foundation
import SwiftData

@Model
final class Pass {
    @Attribute(.unique) var id = UUID()
    var session: Session?
    var timestamp: Date
    var bouys: Double
    var ropeLength: Int
    var boatSpeed: Int
    var completion: Completion // Completed clean, Completed sloppy, Failed Followed Through, Failed Fell,
    var notes: String?

    init(session: Session, timestamp: Date, bouys: Double, ropeLength: Int, boatSpeed: Int, completion: Completion) {
        self.session = session
        self.timestamp = timestamp
        self.bouys = bouys
        self.ropeLength = ropeLength
        self.boatSpeed = boatSpeed
        self.completion = completion
    }
}

extension Pass {
    enum Completion: String, CaseIterable, Codable {
        case clean = "Completed, Clean"
        case sloppy = "Completed, Sloppy"
        case failedNoFall = "Incomplete, didn't fall"
        case failedFall = "Incomplete, fell"
    }
}

