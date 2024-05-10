//
//  ItemListView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/5/24.
//

import SwiftData
import SwiftUI

struct PassView: View {
    @Environment(\.modelContext) private var modelContext
    let session: Session
    @State private var showingAddPass = false
    @State private var newPass: Pass?
    @State private var animate = false
    var body: some View {
        VStack(alignment: .leading) {
            MapView(lat: session.location?.latitude ?? 0.0, long: session.location?.longitude ?? 0.0)
                .frame(height: 100)
                .cornerRadius(25)
                .padding([.horizontal, .top])
            Text("\(session.location?.name ?? "No Name")")
                .font(.title)
                .bold()
                .padding(.leading)
            Text("\(session.startTime, format: .dateTime)")
                .padding(.leading)
            if session.passes.isEmpty {
                VStack(alignment: .leading) {
                    ContentUnavailableView {
                        Label("No passes added yet!", systemImage: "skis")
                            .symbolEffect(.pulse, options: .repeat(3), value: animate)
                            .task {
                                animate = true
                            }
                    } description: {
                        Text("Log Your first pass")
                    } actions: {
                        Button("Add a pass") {
                            showingAddPass.toggle()
                        }
                    }
                }
            } else {
                PassListView
            }
        }
        .sheet(isPresented: $showingAddPass, content: {
            AddPassView(session: session)
                .presentationDetents([.medium])
                .presentationDragIndicator(.automatic)
        })
    }
}

extension PassView {
    private var PassListView: some View {
        List {
            ForEach(session.passes.sorted(by: { $0.timestamp > $1.timestamp })) { pass in
                NavigationLink {
                    ItemDetailView(pass: pass)
                        .navigationTitle("\(pass.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .omitted))")
                } label: {
                    ItemLinkView(pass: pass)
                }
            }
            .onDelete(perform: deleteItems)
            .listRowSeparator(.hidden)
        }
        .navigationTitle("Passes")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: {
                    showingAddPass.toggle()
                }) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(session.passes[index])
            }
        }
    }
}

#Preview("Selected Category") {
    let profile = Profile(name: "Kaden", gender: .female, dateOfBirth: Date(timeIntervalSinceReferenceDate: 0), profilePicture: Data(), prefSpeed: 0, prefLength: 0)
    var session = Session(startTime: Date(), sessionType: .practice, profile: profile)
    session.location?.latitude = 43.153030
    session.location?.longitude = -83.800520
    return PassView(session: session)
}
