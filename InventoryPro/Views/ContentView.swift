//
//  ContentView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/3/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [ItemCategory]
    @State private var showingAddItemSheet = false
    @State private var showingAddCategorySheet = false
    @State private var isActive = false

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(isActive ? 0.5 : 0)
                .animation(.easeOut(duration: 0.2))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/)
            NavigationStack {
                CategoryListView()
            }
            VStack {
                Spacer()
                ZStack {
                    MenuBackground(isActive: isActive)
                    MenuItem(icon: "doc.fill.badge.plus", foreground: Color.yellow, order: 2, isActive: isActive)
                        .onTapGesture {
                            showingAddItemSheet = true
                        }
                    MenuItem(icon: "plus.rectangle.on.folder.fill", foreground: Color.yellow, order: 3, isActive: isActive)
                        .onTapGesture {
                            showingAddCategorySheet = true
                        }
                    MenuItem(icon: "house.fill", foreground: Color.yellow, order: 4, isActive: isActive)
                    MenuItem(icon: "plus", background: Color.purple, foreground: Color.white, size: 24, weight: .bold, order: 0, isActive: isActive, menuIcon: true)
                        .animation(.spring(), value: UUID())
                        .onTapGesture(count: 1) {
                            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                            print("tapped")
                            isActive = !isActive
                        }
                }
            }.padding()
        }
        .navigationTitle("Categories")
        .sheet(isPresented: $showingAddItemSheet, content: {
            AddItemView()
        })
        .sheet(isPresented: $showingAddCategorySheet, content: {
            EditCategoryView()
        })
        .onAppear {
            print(URL.applicationSupportDirectory.path(percentEncoded: false))
        }
    }
}

struct MenuItem: View {
    let positions: [[CGFloat]] = [[0, 0], [-300, 0], [-225, 0], [-150, 0], [-75, 0], [110, 0]]
    let icon: String
    var background: Color = .purple
    var foreground: Color = .blue
    var size: CGFloat = 20
    var weight: Font.Weight = .regular
    var order: Int = 0
    var isActive: Bool = true
    var menuIcon: Bool = false
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: icon)
                .font(Font.system(size: size, weight: weight))
                .frame(width: 60, height: 60)
                .background(.purple)
                .foregroundColor(foreground)
                .cornerRadius(44)
                .rotationEffect(isActive ? .degrees(menuIcon ? 1 : 1080) : .zero)
                .animation(Animation.spring(response: 0.4, dampingFraction: 0.75), value: UUID())
                .offset(x: isActive ? positions[order][0] : 0, y: isActive ? positions[order][1] : 0)
                .rotationEffect((isActive && menuIcon) ? .degrees(-225) : .zero)
        }
    }
}

struct MenuBackground: View {
    @State private var width: CGFloat = 0
    let targetWidth: CGFloat = 345
    var isActive: Bool = true

    var body: some View {
        RoundedRectangle(cornerRadius: 45)
            .frame(width: isActive ? targetWidth : 0, height: 60)
            .foregroundStyle(.purple)
            .animation(Animation.easeInOut(duration: 0.2), value: UUID())
            .offset(x: isActive ? 0 : (targetWidth / 2))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: false)
}
