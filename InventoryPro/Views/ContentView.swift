//
//  ContentView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 1/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [ItemCategory]
    @State private var isShowingSheet = false
    
    var body: some View {
        //        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
        //            AnimalCategoryListView()
        //                .navigationTitle(navigationContext.sidebarTitle)
        //        } content: {
        //            AnimalListView(animalCategoryName: navigationContext.selectedAnimalCategoryName)
        //                .navigationTitle(navigationContext.contentListTitle)
        //        } detail: {
        //            NavigationStack {
        //                AnimalDetailView(animal: navigationContext.selectedAnimal)
        //            }
        //        }
        
        VStack {
            NavigationStack {
                
                CategoryListView()
                    .navigationTitle("Categories")
                
            }

            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        isShowingSheet.toggle()
                    }, label:  {
                        Text("+")
                            .font(.system(.largeTitle))
                            .frame(width: 77, height: 70)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                    }).background(Color.blue)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                }
            }
        }
        .sheet(isPresented: $isShowingSheet, content: {
            AddItemView()
        })
        .onAppear {
            print(URL.applicationSupportDirectory.path(percentEncoded: false))
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: false)
}

