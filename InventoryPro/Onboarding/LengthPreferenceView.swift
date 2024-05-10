//
//  Preferences.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/30/24.
//

import SwiftUI

struct LengthPreferenceView: View {
    @AppStorage("length") private var length = "feet"
    @Binding var startingLength: Double

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
            Spacer()

            Text("What length do you usually start at?")
                .font(.system(size: 30,
                              weight: .bold,
                              design: .rounded))
                .foregroundColor(.waterText)

            Picker(selection: $length, label: Text("feet or meters")) {
                Text("Feet").tag("feet")
                Text("Meters").tag("meters")
                    .foregroundColor(Color.waterText)
                    .font(.system(size: 30,
                                  weight: .bold,
                                  design: .rounded))
            }
            .pickerStyle(.segmented)

            Slider(
                value: $startingLength,
                in: rangeRoapLength,
                step: 1
            ) {
                Text("Length")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            .accentColor(ropeColor(ropeLength: Int(startingLength)))
            .onChange(of: startingLength) {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
            Text("\(formatNumber(convertRopeLength()[Int(startingLength)]))\(length == "feet" ? "'" : "m") off")
                .foregroundColor(Color.waterAccent)
                .font(.system(size: 30,
                              weight: .bold,
                              design: .rounded))
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
    LengthPreferenceView(startingLength: .constant(0.0)) {}
        .padding()
        .previewLayout(.sizeThatFits)
        .background(.waterBackground)
}
