//
//  ItemDetailView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/7/24.
//

import SwiftUI

struct PassDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @AppStorage("speed") private var speed = "mph"
    @AppStorage("length") private var length = "feet"

    @State var pass: Pass
    @State var firstAppear = false

    @State private var bouys: Double = 3
    @State private var ropeLength: Double = 0
    @State private var boatSpeed: Int = 0
    @State private var completion: Pass.Completion = .failedNoFall
    @State private var isEditing = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("\(bouys, format: .number.rounded(increment: 0.1)) @ \(convertedBoatSpeed()[boatSpeed], format: .number.rounded(increment: 0.1)) \(speed.uppercased()) \(convertRopeLength()[Int(ropeLength)], format: .number.rounded(increment: 0.1))\(length == "feet" ? "'" : "m") off")
                    .font(.headline)
                Text("\(completion.rawValue)")
                    .font(.subheadline)
                GeometryReader { geometry in
                    Form {
                        Section {
                            HStack(spacing: 0) {
                                Picker(selection: $bouys, label: Text("Bouys")) {
                                    ForEach(bouysRange, id: \.self) { bouy in
                                        let roundedBouy = String(format: "%.1f", bouy)
                                        Image("\(roundedBouy)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: geometry.size.width * 0.45, height: 75)
                                .onChange(of: bouys) { oldValue, newValue in
                                    if oldValue == 6 && newValue == 5.5 {
                                        completion = .failedNoFall
                                    }

                                    if oldValue == 5.5 && newValue == 6 {
                                        completion = .clean
                                    }
                                }

                                Text("@")

                                Picker(selection: $boatSpeed, label: Text("Boat Speed")) {
                                    ForEach(boatSpeedRoapLengthRAW, id: \.self) { speed in
                                        Text("\(convertedBoatSpeed()[speed], format: .number.rounded(increment: 0.1))").tag(speed)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: geometry.size.width * 0.2, height: 75)

                                Text("\(speed)")
                                Spacer()
                            }
                            .listRowSeparator(.hidden)

                            Slider(
                                value: $ropeLength,
                                in: rangeRoapLength,
                                step: 1
                            ) {
                                Text("Speed")
                            } onEditingChanged: { editing in
                                isEditing = editing
                            }
                            .accentColor(ropeColor(ropeLength: Int(ropeLength)))
                            .onChange(of: ropeLength) {
                                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            }
                            .onAppear {
                                if firstAppear == false {
                                    bouys = pass.bouys
                                    ropeLength = Double(pass.ropeLength)
                                    boatSpeed = pass.boatSpeed
                                    completion = pass.completion
                                }
                            }

                            Picker(selection: $completion, label: Text("Completion")) {
                                if bouys == 6 {
                                    Text(Pass.Completion.clean.rawValue).tag(Pass.Completion.clean)
                                    Text(Pass.Completion.sloppy.rawValue).tag(Pass.Completion.sloppy)
                                } else {
                                    Text(Pass.Completion.failedFall.rawValue).tag(Pass.Completion.failedFall)
                                    Text(Pass.Completion.failedNoFall.rawValue).tag(Pass.Completion.failedNoFall)
                                }
                            }
                        }
                    }
                    .scrollDisabled(true)
                }
                Button {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                    updatePass()
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(-2.0)
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .padding(.top)
        }
    }

    private func updatePass() {
        pass.bouys = bouys
        pass.ropeLength = Int(ropeLength)
        pass.boatSpeed = boatSpeed
        pass.completion = completion
    }
}

#Preview {
    let profile = Profile(name: "Kaden", gender: .female, dateOfBirth: Date(timeIntervalSinceReferenceDate: 0), profilePicture: Data(), prefSpeed: 0, prefLength: 0)
    let session = Session(startTime: Date(), sessionType: .practice, profile: profile)
    let pass = Pass(session: session, timestamp: Date(), bouys: 3.0, ropeLength: boatSpeedRoapLengthRAW[4], boatSpeed: boatSpeedRoapLengthRAW[3], completion: .clean, pointsRaw: 50.0)
    return PassDetailView(pass: pass)
}
