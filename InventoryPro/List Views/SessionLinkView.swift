//
//  CategoryLinkView.swift
//  InventoryPro
//
//  Created by Thompson, Kaden on 1/8/24.
//

import SwiftData
import SwiftUI

struct SessionLinkView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var session: Session
    
    var timeDifference: String {
        let calendar = Calendar.current
        
        if ((session.endTime) != nil) {
            let components = calendar.dateComponents([.hour, .minute], from: session.startTime, to: session.endTime!)
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute]
            formatter.unitsStyle = .positional
            let formattedDuration = formatter.string(from: components)
            return formattedDuration ?? ""
        } else {
            return "--"
        }
    }

    var body: some View {
        HStack {
            HStack(spacing: 0) {
                ZStack {
                    MapView(lat: session.location?.latitude ?? 0.0, long: session.location?.longitude ?? 0.0)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    Image(session.sessionType == Session.SessionType.tournament ? "tournamenttrans" : "practicetrans")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                    
                }
                
            }

            VStack(alignment: .leading, spacing: 0, content: {
                Text("\(session.sessionType)".capitalized)
                    .font(.headline)
                Text("\(session.location?.name ?? "No Name")")
                    .font(.subheadline)
                Spacer()
                HStack(){
                    VStack(spacing: 0) {
                        HStack(alignment: .lastTextBaseline, spacing: 0) {
                            Text("\(session.passes.count)")
                                .font(.title)
                                .foregroundStyle(.red)
                            Text("x")
                                .font(.subheadline)
                                .foregroundStyle(.red)
                        }
                        Text("Passes")
                            .font(.subheadline)
                    }
                    Divider()
                    VStack(spacing: 0) {
                        HStack(alignment: .lastTextBaseline, spacing: 0) {
                            Text("\(timeDifference)")
                                .font(.title)
                                .foregroundStyle(.orange)
                        }
                        Text("Minutes")
                            .font(.subheadline)
                    }
                }
            })
            .padding(.zero)
            Spacer()
        }
    }
}

//#Preview {
//    let cat = Session(name: "Apple")
//    return CategoryLinkView(itemCategory: cat)
//        .modelContainer(for: Session.self, inMemory: false)
//}
