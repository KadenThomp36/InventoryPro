//
//  UsernameView.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/28/24.
//

import SwiftUI

struct UsernameView: View {
    @Binding var text: String
    let action: () -> Void

    @Environment(\.modelContext) private var modelContext

    @State private var name = ""
    private enum Field: Int, CaseIterable {
        case name
    }

    @FocusState private var usernameFieldIsFocused: Bool

    var body: some View {
        VStack {
            Group {
                Text("Let's get started,") +
                    Text("\nWhat's your") +
                    Text(" name").foregroundColor(.waterAccent) +
                    Text("?")
            }
            .font(.system(size: 30,
                          weight: .bold,
                          design: .rounded))
            .padding(.top, 50)
            .padding(.vertical, 10)
            .foregroundColor(.waterText)
            .multilineTextAlignment(.center)

            Spacer()
            
            // TODO: create a button style and textfield style for this
            TextField("", text: $text)
                .frame(width: 350, height: 50)
                .font(.system(size: 56, weight: .bold, design: .rounded))
                .padding(.bottom, 8)
                .accentColor(.waterAccent)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.waterAccent, .waterPrimary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                )                .padding()
                .multilineTextAlignment(.center)
                .focused($usernameFieldIsFocused)

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
        .onAppear {
            usernameFieldIsFocused = true
        }
    }
}

#Preview {
    UsernameView(text: .constant("")) {}
        .padding()
        .previewLayout(.sizeThatFits)
        .background(.waterBackground)
}
