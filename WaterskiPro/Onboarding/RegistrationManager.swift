//
//  RegistrationManager.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/29/24.
//

import Foundation

final class RegistrationManager: ObservableObject {
    enum Screen: Int, CaseIterable {
        case username
        case dateOfBirth
        case lengthPref
        case speedPref
        case bio
    }

    @Published var active: Screen = Screen.allCases.first!
    @Published var user = User(name: "", dateOfBirth: Date(timeIntervalSinceReferenceDate: 0), gender: .unselected, profilePicture: Data(), prefSpeed: 0, prefLength: 1)

    @Published var hasError = false
    @Published var error: RegistrationError?

    func next() {
        let nextScreenIndex = min(active.rawValue + 1, Screen.allCases.last!.rawValue)
        if let screen = Screen(rawValue: nextScreenIndex) {
            active = screen
        }
    }

    func previous() {
        let previousScreenIndex = max(active.rawValue - 1, Screen.allCases.first!.rawValue)
        if let screen = Screen(rawValue: previousScreenIndex) {
            active = screen
        }
    }

    func validateName() {
        hasError = user.name.isEmpty
        error = user.name.isEmpty ? .emptyName : nil
    }

    func validateDOB() {
        hasError = user.dateOfBirth == Date(timeIntervalSinceReferenceDate: 0)
        error = hasError ? .noDobSelected : nil
    }
    
    func validateGender() {
        hasError = user.gender == .unselected
        error = hasError ? .noGenderSelected : nil
    }
}

extension RegistrationManager {
    struct User {
        var name: String
        var dateOfBirth: Date
        var gender: Gender
        var profilePicture: Data
        var prefSpeed: Int
        var prefLength: Double
    }
}

extension RegistrationManager {
    enum RegistrationError: LocalizedError {
        case emptyName
        case noDobSelected
        case noGenderSelected

        var errorDescription: String? {
            switch self {
            case .emptyName:
                return "⚠️ Username is empty"

            case .noDobSelected:
                return "⚠️ Select a Date Of Birth"
                
            case .noGenderSelected:
                return "⚠️ Select a Gender"
            }
        }
    }
}
