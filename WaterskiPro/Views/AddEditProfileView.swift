//
//  AddEditProfileView.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 5/10/24.
//

import PhotosUI
import SwiftUI

struct AddEditProfileView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("activeUser") private var activeUser: UUID?

    @Binding var user: Profile
    var isNewUser = false

    @State var profilePicture: Data = Data()
    @State var dateOfBirth: Date = Date()
    @State var gender: Gender = .male
    @State var name: String = ""
    @State var isWiggle = true
    @State var prefSpeed = 1
    @State var prefLength = 1
    @State var speedUnit = "mph"
    @State var lengthUnit = "feet"
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?

    var body: some View {
        if isNewUser {
            newUserView
        } else {
            editProfileView
                .onAppear {
                    profilePicture = user.profilePicture
                    avatarImage = getImage(imageData: profilePicture)
                    name = user.name
                    gender = user.gender
                    dateOfBirth = user.dateOfBirth
                }
        }
    }
}

extension AddEditProfileView {
    var editProfileView: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    ZStack(alignment: .center) {
                        Circle()
                            .frame(width: 85, height: 85)
                            .foregroundColor(.waterSecondary)
                        PhotosPicker(selection: $photosPickerItem, matching: .images) {
                            Image(uiImage: avatarImage ?? UIImage(resource: .defaultAvatar))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(.circle)
                        }
                        Image(systemName: "pencil")
                            .rotationEffect(.degrees(isWiggle ? 2.5 : 0))
                            .rotation3DEffect(.degrees(5), axis: (x: 0, y: -5, z: 0))
                            .animation(Animation.easeInOut(duration: 0.15).repeatForever(autoreverses: true), value: isWiggle)
                            .font(.system(size: 25))
                            .foregroundStyle(.waterAccent).opacity(0.4)

                    }
                    Spacer()
                }
                TextField("Name", text: $name)
            }
            .onChange(of: photosPickerItem) {
                Task {
                    if let photosPickerItem,
                       let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                        profilePicture = data
                        if let image = UIImage(data: data) {
                            avatarImage = image
                        }
                    }
                    photosPickerItem = nil
                }
            }
            Section {
                DatePicker(selection: $dateOfBirth, displayedComponents: [.date], label: { Text("Date Of Birth") })
                Picker(selection: $gender, label: Text("Gender")) {
                    Text("Select An Option")
                    Text("Male").tag(Gender.male)
                    Text("Female").tag(Gender.female)
                }
            }
            Section {
                Button("Update Profile") {
                    updateProfile()
                }
            }
        }
    }
    
    var newUserView: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    ZStack(alignment: .center) {
                        Circle()
                            .frame(width: 85, height: 85)
                            .foregroundColor(.waterSecondary)
                        PhotosPicker(selection: $photosPickerItem, matching: .images) {
                            Image(uiImage: avatarImage ?? UIImage(resource: .defaultAvatar))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(.circle)
                        }
                        Image(systemName: "pencil")
                            .rotationEffect(.degrees(isWiggle ? 2.5 : 0))
                            .rotation3DEffect(.degrees(5), axis: (x: 0, y: -5, z: 0))
                            .animation(Animation.easeInOut(duration: 0.15).repeatForever(autoreverses: true), value: isWiggle)
                            .font(.system(size: 25))
                            .foregroundStyle(.waterAccent).opacity(0.4)

                    }
                    Spacer()
                }
                TextField("Name", text: $name)
            }
            .onChange(of: photosPickerItem) {
                Task {
                    if let photosPickerItem,
                       let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                        profilePicture = data
                        if let image = UIImage(data: data) {
                            avatarImage = image
                        }
                    }
                    photosPickerItem = nil
                }
            }
            Section {
                DatePicker(selection: $dateOfBirth, displayedComponents: [.date], label: { Text("Date Of Birth") })
                Picker(selection: $gender, label: Text("Gender")) {
                    Text("Select An Option")
                    Text("Male").tag(Gender.male)
                    Text("Female").tag(Gender.female)
                }
            }
            Section() {
                Picker(selection: $prefSpeed, label: Text("Boat Speed")) {
                    ForEach(boatSpeedRoapLengthRAW, id: \.self) { speed in
                        Text("\(formatNumber(convertedBoatSpeed()[speed])) \(speedUnit)").tag(speed)
                    }
                }
                Picker(selection: $prefLength, label: Text("Line Length")) {
                    ForEach(boatSpeedRoapLengthRAW, id: \.self) { speed in
                        Text("\(formatNumber(convertRopeLength()[speed]))\(lengthUnit == "feet" ? "'" : "m") off").tag(speed)
                    }
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
            Section {
                Button("Add Profile") {
                    addProfile()
                }
            }
        }
    }

    private func updateProfile() {
        user.name = name
        user.profilePicture = profilePicture
        user.gender = gender
        user.dateOfBirth = dateOfBirth
        dismiss()
    }
    
    private func addProfile() {
        user.name = name
        user.profilePicture = profilePicture
        user.gender = gender
        user.dateOfBirth = dateOfBirth
        user.profileCreationDate = Date()
        user.prefLength = Double(prefLength)
        user.prefSpeed = prefSpeed
        activeUser = user.id
        modelContext.insert(user)
        try? modelContext.save()
        dismiss()
    }
}

#Preview {
    AddEditProfileView(user: .constant(Profile()), isNewUser: true)
        .modelContainer(for: Profile.self, inMemory: false)
}
