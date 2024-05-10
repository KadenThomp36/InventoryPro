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
//struct EditTagView: View {
//    @Query private var items: [ItemTag]
//    
//    @Binding var itemTags: [ItemTag]
//    @Binding var newItem: Pass
//    
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
//                    ForEach(searchResults, id: \.self) { tag in
//                        MultipleSelectionRow(
//                               tag: tag,
//                               isSelected: isSelected(tag),
//                               action: { toggleSelection(tag) }
//                           )
//                    }
//                    .onDelete(perform: deleteItems)
//                    
//                    NavigationLink {
//                        AddTagView()
//                            .navigationTitle("Add Tag")
//                    } label: {
//                        Text("Add Tag")
//                    }
//                }
//                .searchable(text: $searchText)  
//                Spacer()
//
//            }
//    func isSelected(_ tag: ItemTag) -> Bool {
//        itemTags.contains(tag)
//    }
//
//    func toggleSelection(_ tag: ItemTag) {
//        if isSelected(tag) {
//            itemTags.removeAll { $0 == tag }
//            newItem.tag?.removeAll { $0 == tag }
//        } else {
//            itemTags.append(tag)
//            if (newItem.tag == nil) {
//                newItem.tag = [tag]
//            } else {
//                newItem.tag!.append(tag)
//            }
//        }
//    }
//    
//    var searchResults: [ItemTag] {
//        if searchText.isEmpty {
//            return items
//        } else {
//            return items.filter { $0.name.contains(searchText) }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}
//
//struct MultipleSelectionRow: View {
//    var tag: ItemTag
//    var isSelected: Bool
//    var action: () -> Void
//
//    var body: some View {
//        Button(action: {
//            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
//            action()
//        }) {
//            HStack {
//                Text(tag.name)
//                Spacer()
//                if isSelected {
//                    Image(systemName: "checkmark")
//                        .foregroundColor(.blue)
//                }
//            }
//            .contentShape(Rectangle())
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
////#Preview {
////    @State var itemcat: ItemCategory
////    EditCategoryView(itemCategory: $itemcat)
////}
