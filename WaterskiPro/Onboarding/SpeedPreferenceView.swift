//
//  Preferences.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/30/24.
//

import SwiftUI

struct SpeedPreferenceView: View {
    @AppStorage("speed") private var speed = "mph"
    @Binding var startingSpeed: Int
    
    @State private var isEditing = false
    
    let action: () -> Void
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    @State private var birthDate = Date()
    
    var body: some View {
        VStack {
            Group {
                Text("...and how") +
                    Text(" fast ").foregroundColor(.waterAccent) +
                    Text("do you") +
                    Text("\nlike to go?")
            }
            .font(.system(size: 30,
                          weight: .bold,
                          design: .rounded))
            .padding(.top, 50)
            .padding(.vertical, 10)
            .foregroundColor(.waterText)
            .multilineTextAlignment(.center)
            
            Spacer()
            
            Picker(selection: $speed, label: Text("mph or kph")) {
                Text("MPH").tag("mph")
                Text("KPH").tag("kph")
            }
            .pickerStyle(.segmented)
            
            VStack {
                ForEach(0..<4) { y in // Iterate over rows (4 rows)
                    HStack {
                        ForEach(0..<3) { x in // Iterate over columns (3 columns)
                            Button {
                                let index = y * 3 + x
                                startingSpeed = index
                            } label: {
                                Text("\(formatNumber(convertedBoatSpeed()[y * 3 + x]))")
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(((y * 3 + x) == startingSpeed) ? .waterTextInverse : .waterAccent)
                                    .background(((y * 3 + x) == startingSpeed) ? .waterPrimary : .waterBackground , in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .contentShape(Rectangle())
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            Button("Next") {
                action()
            }
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .padding(.horizontal, 60)
            .padding(.vertical, 15)
            .foregroundColor(.waterTextInverse)
            .background(.waterPrimary, in: RoundedRectangle(cornerRadius: 10,
                                                              style: .continuous))
            .padding(.top, 40)
        }
        .padding()
        .onAppear {
            let thumbImage = UIImage(systemName: "circle.fill")
            UISlider.appearance().setThumbImage(thumbImage, for: .normal)
            UISegmentedControl.appearance().selectedSegmentTintColor = .waterPrimary
            UISegmentedControl.appearance().setTitleTextAttributes(
                [
                    .font: UIFont.boldSystemFont(ofSize: 16),
                    .foregroundColor: UIColor.waterTextInverse,
                ], for: .selected)
            
            UISegmentedControl.appearance().setTitleTextAttributes(
                [
                    .font: UIFont.boldSystemFont(ofSize: 12),
                    .foregroundColor: UIColor.waterText,
                ], for: .normal)
        }
    }
}

#Preview {
    SpeedPreferenceView(startingSpeed: .constant(0)) {}
        .padding()
        .previewLayout(.sizeThatFits)
        .background(.waterBackground)
}
