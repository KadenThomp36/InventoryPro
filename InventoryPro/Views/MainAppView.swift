//
//  MainAppView.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/26/24.
//

import SwiftUI

struct MainAppView: View {
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        ZStack {
            switch session.currentState {
            case .mainView:
                HomeView()
                    .transition(.opacity)
            case .onboarding:
                OnboardingView(action: session.completeOnboarding)
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .signup:
                Color.blue.ignoresSafeArea()
                SignUpView()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
            default:
                // Splash screen
                ZStack {
                    ProgressView()
                    Image("SplashScreen")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all) // Make the image full screen
                }
            }
        }
        .animation(.easeInOut, value: session.currentState)
        .onAppear(perform: session.configureCurrentState)
    }
}

#Preview {
    MainAppView()
        .environmentObject(SessionManager())
}
