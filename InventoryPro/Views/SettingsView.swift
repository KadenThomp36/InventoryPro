//
//  SettingsView.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/22/24.
//

import Foundation
import SwiftData
import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var session: SessionManager
    
    @Query(sort: \Profile.profileCreationDate, order: .reverse) private var users: [Profile]

    @AppStorage("speed") private var speedUnit = "mph"
    @AppStorage("length") private var lengthUnit = "feet"
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = true
    @AppStorage("hasCompletedSignUpFlow") private var hasCompletedSignup = true
    @AppStorage("activeUser") private var activeUser: String?

    @Binding var user: Profile
    
    @State private var avatarImage: UIImage?
    @State private var prefSpeed: Int = 0
    @State private var prefLength: Int = 0
    @State var ageGroup = ""
    @State var isShowingEditProfile = false
    @State var animate = false

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    let logOut: () -> Void

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Menu {
                    ForEach(users, id: \.self) { user in
                        Button("\(user.name)") {
                            activeUser = user.name
                        }
                    }
                    Button("+ New User") {
                        session.completeOnboarding()
                    }
                } label: {
                    HStack(spacing: 5) {
                        Text("\(activeUser ?? "Login")")
                        Image(systemName: "chevron.down")
                    }
                }
                .padding(.horizontal, 15)
                .background(.waterPrimary)
                .foregroundStyle(.waterTextInverse)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .padding(.trailing, 20)
            }

            Form {
                Section {
                    VStack {
                        HStack(alignment: .center) {
                            Image(uiImage: avatarImage ?? UIImage(resource: .defaultAvatar))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(.circle)
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Text("\(user.name)")
                                        .font(.system(size: 30,
                                                      weight: .bold,
                                                      design: .rounded))
                                        .foregroundStyle(.waterAccent)
                                    Spacer()
                                    Button {
                                        isShowingEditProfile.toggle()
                                    } label: {
                                        Image(systemName: "pencil.and.scribble")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                HStack(alignment: .center) {
                                    VStack {
                                        Text("Division")
                                            .font(.system(size: 15,
                                                          weight: .light,
                                                          design: .rounded))
                                        Spacer()
                                        Text("\(ageGroup)")
                                            .font(.system(size: 15,
                                                          weight: .light,
                                                          design: .rounded))
                                            .foregroundStyle(.waterPrimary)
                                        Spacer()
                                    }
                                    Divider()
                                        .frame(width: 1)
                                    VStack {
                                        Text("Member Since")
                                            .font(.system(size: 15,
                                                          weight: .light,
                                                          design: .rounded))
                                        Spacer()
                                        Text("\(dateFormatter.string(from: user.profileCreationDate))")
                                            .font(.system(size: 15,
                                                          weight: .light,
                                                          design: .rounded))
                                            .foregroundStyle(.waterPrimary)
                                        Spacer()
                                    }
                                }
                                .padding(.top)

                                Spacer()
                            }
                            .padding(.leading)
                        }
                        .padding(.vertical, 5)
                    }
                    .onChange(of: activeUser) {
                        setActiveUser()
                    }
                }

                Section(header: Text("Pass Preferences")) {
                    Picker(selection: $prefSpeed, label: Text("Boat Speed")) {
                        ForEach(boatSpeedRoapLengthRAW, id: \.self) { speed in
                            Text("\(formatNumber(convertedBoatSpeed()[speed])) \(speedUnit)").tag(speed)
                        }
                    }
                    .onChange(of: prefSpeed) {
                        updateSpeed()
                    }

                    Picker(selection: $prefLength, label: Text("Line Length")) {
                        ForEach(boatSpeedRoapLengthRAW, id: \.self) { speed in
                            Text("\(formatNumber(convertRopeLength()[speed]))\(lengthUnit == "feet" ? "'" : "m") off").tag(speed)
                        }
                    }
                    .onChange(of: prefLength) {
                        updateLength()
                    }
                }

                Section(header: Text("units")) {
                    HStack {
                        Picker(selection: $speedUnit,
                               label: Label("Speed", systemImage: "gauge.open.with.lines.needle.33percent")
                                   .labelStyle(.automatic)
                                   .foregroundColor(.primary)) {
                            Text("MPH").tag("mph")
                            Text("KPH").tag("kph")
                        }
                    }
                    HStack {
                        Picker(selection: $lengthUnit,
                               label: Label("Rope Length", systemImage: "ruler")
                                   .labelStyle(.automatic)
                                   .foregroundColor(.primary)) {
                            Text("Feet").tag("feet")
                            Text("Meters").tag("meters")
                        }
                    }
                }
                
                Section() {
                    Button("re-trigger onboarding on next open") {
                        hasSeenOnboarding = false
                        hasCompletedSignup = false
                    }
                    Button("Log Out") {
                        logOut()
                    }
                    .foregroundStyle(.red)
                    Button("Delete User") {
                        //TODO: Prompt for confirmation
                        deleteUser()
                    }
                    .foregroundStyle(.red)
                    
                }
            }
            .scrollDisabled(Bool(true))
        }
        .onAppear {
            setActiveUser()
        }
        .sheet(isPresented: $isShowingEditProfile, content: {
            Text("Edit Profile")
        })
    }
    
    private func deleteUser() {
        modelContext.delete(user)
        logOut()
    }

    private func setActiveUser() {
        let userProfile = getActiveUser(activeUser: activeUser ?? "", users: users)
        if userProfile.found {
            user = userProfile.user
            ageGroup = getAgeGroup(gender: userProfile.user.gender, dateOfBirth: userProfile.user.dateOfBirth)
            prefSpeed = userProfile.user.prefSpeed
            prefLength = Int(userProfile.user.prefLength)
            avatarImage = getImage(imageData: userProfile.user.profilePicture)
        }
    }

//    private func getImage(imageData: Data) -> UIImage {
//        return UIImage(data: imageData) ?? UIImage(resource: .defaultAvatar)
//
//    }

    private func updateSpeed() {
        user.prefSpeed = prefSpeed
    }

    private func updateLength() {
        user.prefLength = Double(prefLength)
    }
}

#Preview {
    SettingsView(user: .constant(Profile())) {}
}
