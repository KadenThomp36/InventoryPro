//
//  OnboardingManager.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/26/24.
//

import Foundation

struct OnboardingItem: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let content: String
}

extension OnboardingItem: Equatable {}

final class OnboardingManager: ObservableObject {
    @Published private(set) var items: [OnboardingItem] = []

    func load() {
        items = [
            .init(emoji: "🤝",
                  title: "Join the crew",
                  content: "In ex voluptate aute magna velit."),
            .init(emoji: "❤️",
                  title: "Support the crew",
                  content: "In ex voluptate aute magna velit."),
            .init(emoji: "🥳",
                  title: "Celebrate the crew",
                  content: "In ex voluptate aute magna velit."),
            .init(emoji: "🥵",
                  title: "Hot the crew",
                  content: "In ex voluptate aute magna velit."),
        ]
    }
}
