import Foundation
import SwiftData

@Model
final class Profile: ObservableObject {
    @Attribute(.unique) var id = UUID()
    @Relationship(deleteRule: .cascade, inverse: \Session.profile)
    var sessions: [Session] = []
    var profileCreationDate: Date
    var name: String
    var gender: Gender
    var dateOfBirth: Date
    var profilePicture: Data
    var isLoggedIn: Bool
    var prefSpeed: Int
    var prefLength: Double

    init(){
        self.profileCreationDate = Date()
        self.name = ""
        self.gender = .unselected
        self.dateOfBirth = Date()
        self.profilePicture = Data()
        self.isLoggedIn = true
        self.prefSpeed = 0
        self.prefLength = 0.0
    }
    
    init(name: String, gender: Gender, dateOfBirth: Date, profilePicture: Data, prefSpeed: Int, prefLength: Double) {
        self.isLoggedIn = true
        self.profileCreationDate = Date()
        self.name = name
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.profilePicture = profilePicture
        self.prefSpeed = prefSpeed
        self.prefLength = prefLength
    }
}


