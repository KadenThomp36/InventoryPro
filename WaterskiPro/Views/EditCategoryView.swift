////
////  EditCategoryView.swift
////  InventoryPro
////
////  Created by Kaden Thompson on 1/15/24.
////
//
//import SwiftData
//import SwiftUI
//
//struct EditCategoryView: View {
//    @Query private var categories: [Session]
//    
//    @Binding var itemCategory: Session?
//
//    @Environment(\.dismiss) private var dismiss
//    @Environment(\.modelContext) private var modelContext
//    
//    @State private var searchText = ""
//
//    var body: some View {
//
//
//                List {
//                    ForEach(searchResults, id: \.self) { cat in
//                        Button(action: {
//                            itemCategory = cat
//                            dismiss()
//                        }) {
//                            HStack {
//                                Image(systemName: cat.icon)
//                                Text("\(cat.name)")
//                                    .foregroundStyle(.black)
//                            }
//       
//                        }
//                    }
//                    .onDelete(perform: deleteItems)
//                    
//                    NavigationLink {
//                        AddCategoryView()
//                            .navigationTitle("Add Category")
//                    } label: {
//                        Text("Add Category")
//                    }
//                }
//                .searchable(text: $searchText)  
//                Spacer()
//
//            }
//    
//    var searchResults: [Session] {
//        if searchText.isEmpty {
//            return categories
//        } else {
//            return categories.filter { $0.name.contains(searchText) }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(categories[index])
//            }
//        }
//    }
//}
//
////#Preview {
////    @State var itemcat: ItemCategory
////    EditCategoryView(itemCategory: $itemcat)
////}
