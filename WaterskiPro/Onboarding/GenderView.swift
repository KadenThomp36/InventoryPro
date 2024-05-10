//
//  Gender.swift
//  Waterski Pro
//
//  Created by Kaden Thompson on 4/28/24.
//

import SwiftUI

struct GenderView: View {
    var body: some View {
        VStack {
            
            Text("⚧️")
                .font(.system(size: 100))
            
            Text("Gender")
                .font(.system(size: 30,
                              weight: .bold,
                              design: .rounded))
                .foregroundColor(.white)
            
            Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                Text("Male").tag(1)
                Text("Female").tag(2)
            }
            .pickerStyle(.automatic)
            .padding()
            .frame(width: 350, height: 50)
            .background(.white, in: RoundedRectangle(cornerRadius: 10,
                                                     style: .continuous))
            .font(.system(size: 13, weight: .bold, design: .rounded))
            .padding(.bottom, 8)
            
            Button("Next") {
                
            }
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .padding(.horizontal, 60)
            .padding(.vertical, 15)
            .background(.white, in: RoundedRectangle(cornerRadius: 10,
                                                     style: .continuous))
            .padding(.top, 40)
        }
    }
}

#Preview {
    GenderView()
        .padding()
        .previewLayout(.sizeThatFits)
        .background(.blue)
}
