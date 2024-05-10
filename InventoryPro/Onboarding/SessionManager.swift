//
//  SessionManager.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/26/24.
//

import Foundation
import SwiftData

final class SessionManager: ObservableObject {
        
    enum UserDefaultKeys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
        static let hasCompletedSignUpFlow = "hasCompletedSignUpFlow"
    }
    
    enum CurrentState {
        case mainView
        case onboarding
        case signup
    }
    
    @Published private(set) var currentState: CurrentState?
    
    func mainView() {
        currentState = .mainView
    }
    
    func register() {
        mainView()
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasCompletedSignUpFlow)

    }
    
    func completeOnboarding() {
        currentState = .signup
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasSeenOnboarding)
    }
    
    func configureCurrentState() {
        
        
        let hasCompletedSignUpFlow = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasCompletedSignUpFlow)
        let hasCompleteOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
        
        if hasCompletedSignUpFlow {
            currentState = .mainView
        } else {
            currentState = hasCompleteOnboarding ? .signup : .onboarding
        }
    }
}
