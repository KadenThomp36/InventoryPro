//
//  AgeView.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/28/24.
//

import Foundation
import SwiftUI

struct AgeView: View {
    @Binding var dateOfBirth: Date
    // @Binding var isScrollEnabled: Bool
    @Binding var isShowingDatePicker: Bool
    @State var selectionMade = false
    let action: () -> Void

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()

    @State private var birthDate = Date()

    var body: some View {
        VStack {
            Text("Also, when were you born?")
                .font(.system(size: 30,
                              weight: .bold,
                              design: .rounded))
                .foregroundColor(.waterText)
                .multilineTextAlignment(.center)
                .padding(.top, 50)
                .padding(.vertical, 10)
            Text("this helps us find your age group")
                .font(.system(size: 16,
                              weight: .bold,
                              design: .rounded))
                .foregroundColor(.waterPrimary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            Spacer()
            VStack {
                Button(action: {
                    isShowingDatePicker = true
                }, label: {
                    Text("\(selectionMade ? dateFormatter.string(from: dateOfBirth) : "DD/MM/YYYY")")
                        .font(.system(size: 30,
                                      weight: .bold,
                                      design: .rounded))
                        // .foregroundColor(.waterText)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.waterAccent, .waterPrimary],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                        )
                })
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
        .onChange(of: isShowingDatePicker) {
            dateOfBirth += 1
            selectionMade = true
        }
        .sheet(isPresented: $isShowingDatePicker, content: {
            DatePicker(selection: $dateOfBirth, displayedComponents: [.date], label: { Text("Date Of Birth") })
                .tint(.waterPrimary)
                .datePickerStyle(.graphical)
                .presentationDetents([.medium])
                .presentationDragIndicator(.automatic)

        })
    }
}

#Preview {
    AgeView(dateOfBirth: .constant(Date()), isShowingDatePicker: .constant(true)) {}
        .padding()
        .previewLayout(.sizeThatFits)
        .background(.waterBackground)
}
