//
//  OnboardingInfoView.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/26/24.
//

import SwiftUI

struct OnboardingInfoView: View {
    
    let item: OnboardingItem
    
    var body: some View {
        VStack(spacing: 0) {
            
            Text(item.emoji)
                .font(.system(size: 150))
            
            Text(item.title)
                .foregroundColor(.waterAccent)
                .font(.system(size: 35,
                              weight: .heavy,
                              design: .rounded))
                .padding(.bottom, 12)
            
            Text(item.content)
                .font(.system(size: 18,
                              weight: .light,
                              design: .rounded))
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.waterText)
        .padding()
    }
}

#Preview {
    OnboardingInfoView(item: .init(emoji: "🤝", title: "Join the crew", content: "In ex voluptate aute magna velit."))
        .previewLayout(.sizeThatFits)
        .background(.waterBackground)
}
