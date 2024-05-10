////
////  AddCategoryView.swift
////  InventoryPro
////
////  Created by Kaden Thompson on 1/15/24.
////
//
//import SwiftData
//import SwiftUI
//import Drops
//
//struct AddTagView: View {
//    @State private var iconPickerPresented = false
//    @State private var bgColor =
//        Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
//    @State private var resolvedColor: Color.Resolved?
//    @State private var tagName: String = ""
//    @State private var isInputAlertShown = false
//    @Environment(\.self) var environment
//
//    @Environment(\.modelContext) private var modelContext
//    @Environment(\.dismiss) private var dismiss
//    var body: some View {
//        Form {
//           
//            HStack {
//                ColorPicker("Tag Color", selection: $bgColor, supportsOpacity: false)
//                TextField("Tag Name", text: $tagName)
//                Spacer()
//            }
//        }
//        .onChange(of: bgColor, initial: true, getColor)
//        .toolbar {
//            ToolbarItem {
//                Button(action: {
//                    let generator = UINotificationFeedbackGenerator()
//                    generator.notificationOccurred(.success)
//                    addTag()
//
//                }) {
//                    Text("Save")
//                }
//            }
//        }
//        .sheet(isPresented: $iconPickerPresented, content: {
//            
//        })
//
//        .alert(isPresented: $isInputAlertShown) {
//            Alert(title: Text("All fields must contain values"))
//        }
//    }
//    
//    private func getColor() {
//        resolvedColor = bgColor.resolve(in: environment)
//    }
//
//    private func addTag() {
//        if tagName == "" {
//            isInputAlertShown = true
//            return
//        }
//        withAnimation {
//            let newCat = ItemTag(
//                name: tagName,
//                r: resolvedColor?.red ?? 0.0,
//                g: resolvedColor?.green ?? 0.0,
//                b: resolvedColor?.blue ?? 0.0
//            )
//            modelContext.insert(newCat)
//            let drop = Drop(title: "Tag Added!", subtitle: "\(tagName)")
//            tagName = ""
//            try? modelContext.save()
//            Drops.show(drop)
//        }
//        
//    }
//}
//
//#Preview {
//    AddTagView()
//        .modelContainer(for: Session.self, inMemory: false)
//}
