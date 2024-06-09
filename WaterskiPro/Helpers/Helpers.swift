//
//  Helpers.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/22/24.
//

import Foundation
import SwiftData
import SwiftUI

extension UUID: RawRepresentable {
    public var rawValue: String {
        self.uuidString
    }

    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        self.init(uuidString: rawValue)
    }
}

enum SessionType: String, CaseIterable, Codable {
    case imperial = "Imperial"
    case metric = "Metric"
}

enum Gender: String, CaseIterable, Codable {
    case unselected = "Select an option"
    case male = "Male"
    case female = "Female"
    case unspecified = "Prefer Not To Say"
}

let rangeBouys = 0.0 ... 6.0
let rangeBoatSpeed = 0 ... 11
let rangeRoapLength = 0.0 ... 11.0

let bouysRange = [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6]

let boatSpeedRoapLengthRAW: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
let boatSpeedKPH: [Double] = [25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55, 58]
let boatspeedMPH: [Double] = [15.5, 17.4, 19.3, 21.1, 23.0, 24.9, 26.7, 28.6, 30.4, 32.3, 34.2, 36.0]

let rangeRopeLengthsMeterOff: [Double] = [0, 4.75, 7, 8.75, 10, 11, 11.75, 12.25, 12.75, 13.25, 13.5, 13.75]
let rangeRopeLengthsFeetOff: [Double] = [0, 15, 22, 28, 32, 35, 38, 39.5, 41, 43, 44, 45]

func convertedBoatSpeed() -> [Double] {
    @AppStorage("speed") var speed = "mph"

    if speed == "mph" {
        return boatspeedMPH
    } else {
        return boatSpeedKPH
    }
}

func convertRopeLength() -> [Double] {
    @AppStorage("length") var length = "feet"

    if length == "feet" {
        return rangeRopeLengthsFeetOff
    } else {
        return rangeRopeLengthsMeterOff
    }
}

func formatNumber(_ number: Double) -> String {
    if number.truncatingRemainder(dividingBy: 1) == 0 {
        return String(format: "%.0f", number)
    } else {
        return String(format: "%.1f", number)
    }
}

func ropeColor(ropeLength: Int) -> Color {
    switch ropeLength {
    case 0:
        return .gray
    case 1:
        return .red
    case 2:
        return .orange
    case 3:
        return .yellow
    case 4:
        return .green
    case 5:
        return .blue
    case 6:
        return .purple
    case 7:
        return .gray
    case 8:
        return .pink
    case 9:
        return .black
    case 10:
        return .red
    case 11:
        return .gray
    default:
        return .gray
    }
}

func getAgeGroup(gender: Gender, dateOfBirth: Date) -> String {
    var ageGroup = ""
    let calendar = Calendar.current
    let currentDate = Date()
    let dobComponents = calendar.dateComponents([.year, .month, .day], from: dateOfBirth)
    let currentComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)

    var ageYears = currentComponents.year! - dobComponents.year!
    let ageMonths = currentComponents.month! - dobComponents.month!
    let ageDays = currentComponents.day! - dobComponents.day!

    // Adjust age if current date hasn't been reached yet
    if ageMonths < 0 || (ageMonths == 0 && ageDays < 0) {
        ageYears = ageYears - 1
    }
    print("AGE----", ageYears)
    switch ageYears {
    case 0 ..< 17:
        if gender == .male {
            ageGroup = "Boys "
        } else {
            ageGroup = "Girls "
        }
    case 18...:
        if gender == .male {
            ageGroup = "Mens "
        } else {
            ageGroup = "Womans "
        }
    default:
        ageGroup = "Gender Missing"
    }

    switch ageYears {
    case 0 ..< 10:
        ageGroup += "1"
    case 10 ..< 11:
        ageGroup += "2"
    case 11 ..< 13:
        ageGroup += "3"
    case 13 ..< 15:
        ageGroup += "4"
    case 15 ..< 17:
        ageGroup += "5"
    case 18 ..< 25:
        ageGroup += "1"
    case 25 ..< 35:
        ageGroup += "2"
    case 35 ..< 45:
        ageGroup += "3"
    case 45 ..< 55:
        ageGroup += "4"
    case 55 ..< 60:
        ageGroup += "5"
    case 60 ..< 65:
        ageGroup += "6"
    case 65 ..< 70:
        ageGroup += "7"
    case 70 ..< 75:
        ageGroup += "8"
    case 75 ..< 80:
        ageGroup += "9"
    case 80 ..< 85:
        ageGroup += "10"
    case 85...:
        ageGroup += "11"
    default:
        ageGroup = "Age Missing"
    }

    return ageGroup
}


@Query() var sessions: [Session]
//@Query() var users: [Profile]

//func getLoggedInUser(name: String) -> Profile {
//    return users.filter { $0.name == name }.first ?? Profile()
//}

func getLastPass(session: Session) -> Pass {
    let currentSession = sessions.filter { $0 == session }
    return currentSession[0].passes.first!
}

func getImage(imageData: Data) -> UIImage {
    return UIImage(data: imageData) ?? UIImage(resource: .defaultAvatar)

}

func getActiveUser(activeUser: UUID, users: [Profile]) -> (user: Profile, found: Bool){
    
    print("active user -> ", activeUser)
    print(users)
    if let userProfile = users.first(where: { $0.id == activeUser }) {
        return (user: userProfile, found: true)
    } else {
        return (user: Profile(), found: false)
    }
}
