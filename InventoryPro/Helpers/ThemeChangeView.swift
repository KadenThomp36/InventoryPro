//
//  ThemeChangeView.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 5/8/24.
//

import SwiftUI

struct ThemeChangeView: View {
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

enum Theme: String, CaseIterable {
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    func color(_ scheme: ColorScheme) -> Color {
        switch self {
        case .systemDefault:
            return scheme == .dark ? . 
        case .light:
            <#code#>
        case .dark:
            <#code#>
        }
    }
}

#Preview {
    ThemeChangeView()
}
