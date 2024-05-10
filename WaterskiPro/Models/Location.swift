import SwiftData
import Foundation

@Model
final class Location: ObservableObject {
    @Attribute(.unique) var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double

    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
