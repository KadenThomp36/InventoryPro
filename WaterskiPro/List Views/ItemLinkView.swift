//
//  ItemLinkView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/8/24.
//

import SwiftUI

struct ItemLinkView: View {
    @AppStorage("length") private var length = "feet"
    @AppStorage("speed") private var speed = "mph"

    var pass: Pass
    var body: some View {
        VStack {
            HStack {
                Text("\(pass.timestamp, format: Date.FormatStyle(date: .omitted, time: .shortened))")

                Spacer()
                Text("\(formatNumber(BoysGirlsOne(rLength: pass.ropeLength, bSpeed: pass.boatSpeed, bouys: pass.bouys))) pts")
                Spacer()
            }
            .font(.headline)
            HStack {
                HStack {
                    Image(systemName: "ruler")
                    Text("\(formatNumber(convertRopeLength()[Int(pass.ropeLength)]))")
                    Text("\(length == "feet" ? "'" : "m") off")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                        .padding([.leading, .bottom], -5.0)
                }
                Spacer()

                HStack {
                    Image(systemName: "gauge.open.with.lines.needle.33percent")
                    Text("\(formatNumber(convertedBoatSpeed()[pass.boatSpeed]))")
                    Text("\(speed)")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                        .padding([.leading, .bottom], -5.0)
                }

                Spacer()

                HStack {
                    Image("buoy.SFSymbol")
                        .font(Font.system(size: 20, weight: .heavy))
//                        .rotationEffect(.degrees(-45)) // Rotate by 90 degrees
                    Text("\(formatNumber(pass.bouys))")
                    Text("bouys")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                        .padding([.leading, .bottom], -5.0)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    let profile = Profile(name: "Kaden", gender: .female, dateOfBirth: Date(timeIntervalSinceReferenceDate: 0), profilePicture: Data(), prefSpeed: 0, prefLength: 0)
    let session = Session(startTime: Date(), sessionType: .practice, profile: profile)
    let pass = Pass(session: session, timestamp: Date(), bouys: 3.0, ropeLength: boatSpeedRoapLengthRAW[4], boatSpeed: boatSpeedRoapLengthRAW[3], completion: .clean)
    return ItemLinkView(pass: pass)
}
