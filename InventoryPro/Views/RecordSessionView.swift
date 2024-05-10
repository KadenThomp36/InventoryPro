//
//  AddCategoryView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/15/24.
//

import CoreLocation
import SwiftData
import SwiftUI
import SymbolPicker

struct RecordSessionView: View {
    @Query() private var locations: [Location]
    
    @AppStorage("speed") private var speedUnit = "mph"
    @AppStorage("length") private var lengthUnit = "feet"
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = true
    @AppStorage("hasCompletedSignUpFlow") private var hasCompletedSignup = true
    @AppStorage("activeUser") private var activeUser: String?

    @Binding var user: Profile
    
    @State private var iconPickerPresented = false
    @State private var icon = "plus.square.dashed"
    @State private var sessionType: Session.SessionType = .practice
    @State private var isInputAlertShown = false

    @State private var locationName: String = ""
    @State private var coordinateMatch: Bool = false

    @State private var existingLocation: Location = Location(name: "", latitude: 0.0, longitude: 0.0)
    @State private var activeSession: Session?
    @State private var running: Bool = false
    @State private var currentLocation: CLLocationCoordinate2D?
    @State private var animate = false

    @Binding var tabSelection: Int

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @StateObject var locationDataManager = LocationDataManager()

    let generator = UINotificationFeedbackGenerator()

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack(alignment: .leading) {
                    switch locationDataManager.locationManager.authorizationStatus {
                    case .authorizedWhenInUse:
                        MapViewDynamic(location: $existingLocation)
                            .frame(height: geometry.size.height * 0.5)
                            .cornerRadius(16)
                            .padding(0)
                            .mask(LinearGradient(gradient: Gradient(stops: [
                                .init(color: .black, location: 0.55),
                                .init(color: .clear, location: 1),
                            ]), startPoint: .top, endPoint: .bottom))
                            .ignoresSafeArea(.all)
                            .onAppear {
                                locationDataManager.updateLocation()
                                existingLocation = checkForCoordinateMatch(margin: 0.01)
                            }

                        Text("\((existingLocation.name != "") ? existingLocation.name : locationName)")
                            .font(.title)
                            .bold()
                            .padding(.top, -65.952)
                            .padding(.leading)
                        Spacer()

                    case .restricted, .denied: // Location services currently unavailable.
                        // Insert code here of what should happen when Location services are NOT authorized
                        Text("Current location data was restricted or denied.")
                    case .notDetermined: // Authorization not determined yet.
                        VStack(alignment: .center) {
                            ProgressView("Finding your location...") // larger spinner and smaller text
                                .scaleEffect(3)
                                .font(.system(size: 8))
                                .frame(width: 150, height: 150)
                        }

                    default:
                        ProgressView()
                    }
                    VStack(alignment: .center) {
                        Form {
                            if (existingLocation.name == "") && activeSession == nil {
                                // Add the new coordinate to the database
                                TextField("Location Name", text: $locationName)
                                    .padding(.horizontal)
                            }
                            Picker(selection: $sessionType, label: Text("Session Type")) {
                                ForEach(Session.SessionType.allCases, id: \.self) { sessionType in
                                    Text(sessionType.rawValue).tag(sessionType)
                                }
                            }
                            .pickerStyle(.navigationLink)
                            .padding()
                            HStack {
                                Spacer()
                                Button(action: {
                                    if activeSession == nil {
                                        generator.notificationOccurred(.success)
                                        startSession()
                                    } else {
                                        endSession()
                                        generator.notificationOccurred(.success)
                                    }

                                }) {
                                    VStack(alignment: .center) {
                                        Text((activeSession == nil) ? "Start Session" : "Stop Session")
                                            .frame(width: geometry.size.width * 0.85)
                                    }
                                }
                                .buttonStyle(StartButton())
                                Spacer()
                            }
                        }
                        .formStyle(.columns)
                        .frame(width: geometry.size.width * 1, height: geometry.size.height * 0.25)
                        .scrollDisabled(true)

                        .scrollContentBackground(.hidden)
                        .onAppear {
                            locationDataManager.updateLocation()
                            existingLocation = checkForCoordinateMatch(margin: 0.01)
                            isRunning()
                        }
                        .sheet(isPresented: $running, content: {
                            NavigationView {
                                PassView(session: activeSession!)
                                    .interactiveDismissDisabled(true)
                                    .toolbar {
                                        ToolbarItem {
                                            Button(action: {
                                                endSession()
                                            }) {
                                                Text("End")
                                            }
                                        }
                                    }
                            }
                        }
                        )
                    }
                }
            }
        }
        .alert(isPresented: $isInputAlertShown) {
            Alert(title: Text("All fields must contain values"))
        }
    }

    private func checkForCoordinateMatch(margin: Double) -> Location {
        for location in locations {
            // TODO: Not working
            let latDiff = abs((locationDataManager.locationManager.location?.coordinate.latitude ?? 0.0) - location.latitude)
            let lonDiff = abs((locationDataManager.locationManager.location?.coordinate.longitude ?? 0.0) - location.longitude)
            if latDiff < margin && lonDiff < margin {
                print("MATCH FOUND", location.latitude, location.longitude)
                existingLocation = location
                return location
            }
        }
        existingLocation.latitude = locationDataManager.locationManager.location?.coordinate.latitude ?? 0.0
        existingLocation.longitude = locationDataManager.locationManager.location?.coordinate.longitude ?? 0.0
        print("New Location!", existingLocation.latitude, existingLocation.longitude)
        return existingLocation
    }

    private func isRunning() {
        for session in user.sessions {
            if session.active {
                activeSession = session
                running = true
            }
        }
    }

    private func endSession() {
        activeSession!.endTime = Date()
        activeSession!.active = false
        activeSession = nil
        running = false
    }

    private func startSession() {
        withAnimation {
            let newSession = Session(
                startTime: Date(),
                sessionType: self.sessionType,
                profile: user
            )
            
            existingLocation.name = locationName
            newSession.location = existingLocation
            activeSession = newSession
            running = true
            
            user.sessions.append(newSession)
        }
        dismiss()
    }
}

struct StartButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5.0, height: 5.0)))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// #Preview {
//    AddSessionView()
//        .modelContainer(for: Session.self, inMemory: false)
// }
