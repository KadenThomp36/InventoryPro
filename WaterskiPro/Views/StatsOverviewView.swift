//
//  StatsOverviewView.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 6/16/24.
//

import SwiftUI

struct StatsOverviewView: View {
    @Binding var user: Profile
    @Binding var tabSelection: Int

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let newProfile = Profile(name: "Kaden", gender: .male, dateOfBirth: Date(), profilePicture: Data(), prefSpeed: 100, prefLength: 100)
    StatsOverviewView(user: .constant(newProfile), tabSelection: .constant(3))
}
