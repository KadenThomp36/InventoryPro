//
//  SkiViewModel.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 3/28/24.
//

import Foundation
import SwiftData

@Observable
class SkiViewModel {
    func addPass(context: ModelContext, session: Session) {
        let newPass = Pass(session: session, timestamp: Date(), bouys: 0.0, ropeLength: 0, boatSpeed: 0, completion: Pass.Completion.clean)
        context.insert(newPass)
    }
}
