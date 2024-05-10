//
//  SignUpView.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/29/24.
//

import SwiftUI

struct SignUpView: View {
    @AppStorage("activeUser") private var activeUser: String?

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var session: SessionManager

    @StateObject private var manager = RegistrationManager()
    @State private var showPrevBtn = false
    @State private var showTerms = false
    @State private var isRegistering = false
    @State private var isScrollEnabled = false

    var body: some View {
        ZStack {
            Color.waterBackground.ignoresSafeArea()
            TabView(selection: $manager.active) {
                UsernameView(text: $manager.user.name) {
                    manager.validateName()
                    if !manager.hasError {
                        // dismiss keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        manager.next()
                    }
                }
                .tag(RegistrationManager.Screen.username)
                AgeView(dateOfBirth: $manager.user.dateOfBirth, isShowingDatePicker: $isScrollEnabled, action: manager.next)
                    .tag(RegistrationManager.Screen.dateOfBirth)
                LengthPreferenceView(startingLength: $manager.user.prefLength, action: manager.next)
                    .tag(RegistrationManager.Screen.lengthPref)
                SpeedPreferenceView(startingSpeed: $manager.user.prefSpeed, action: manager.next)
                    .tag(RegistrationManager.Screen.speedPref)
                ProfilePicture(gender: $manager.user.gender, profilePicture: $manager.user.profilePicture) {
                    showTerms.toggle()
                }
                .tag(RegistrationManager.Screen.bio)
            }
            .animation(.easeInOut, value: manager.active)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .sheet(isPresented: $showTerms, content: {
                TermsAgreementView {
                    isRegistering = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isRegistering = false
                        registerUser()
                        session.register()
                    }
                }
                .overlay {
                    if isRegistering {
                        Color.black.opacity(0.4).ignoresSafeArea()
                        ProgressView()
                            .tint(.white)
                    }
                }
                .interactiveDismissDisabled(isRegistering)
                .animation(.easeInOut, value: isRegistering)
            })
        }
        .overlay(alignment: .topLeading) {
            if showPrevBtn {
                Button(action: manager.previous, label: {
                    Image(systemName: "chevron.backward")
                        .symbolVariant(.circle.fill)
                        .foregroundColor(.waterPrimary)
                        .font(.system(size: 35,
                                      weight: .bold,
                                      design: .rounded))
                        .padding()

                })
            }
        }
        .animation(.easeInOut, value: showPrevBtn)
        .onAppear {
            UIScrollView.appearance().isScrollEnabled = false
        }
        .onDisappear {
            UIScrollView.appearance().isScrollEnabled = true
        }
        .onChange(of: isScrollEnabled, { 
            UIScrollView.appearance().isScrollEnabled = isScrollEnabled
        })
        .onChange(of: manager.active) {
            if manager.active == RegistrationManager.Screen.allCases.first {
                showPrevBtn = false
            } else {
                showPrevBtn = true
            }
        }
        .alert(isPresented: $manager.hasError, error: manager.error) { }
    }

    private func registerUser() {
        let newProfile: Profile = Profile(name: manager.user.name, gender: manager.user.gender, dateOfBirth: manager.user.dateOfBirth, profilePicture: manager.user.profilePicture, prefSpeed: manager.user.prefSpeed, prefLength: manager.user.prefLength)
        activeUser = manager.user.name
        modelContext.insert(newProfile)
        try? modelContext.save()
    }
}

#Preview {
    SignUpView()
        .environmentObject(SessionManager())
}
