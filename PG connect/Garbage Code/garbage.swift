//
//import SwiftUI
//
//struct food_sheet: View {
//    @Binding var selectedPreferences4: [String]
//    let foodType = ["Veg", "Non Veg"]
//    @State private var selectedIndex_food: Int? = nil
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//
//        VStack {
//            HStack {
//                Text("Food Type")
//                    .fontWeight(.semibold)
//                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
//                    .font(.system(size: 18))
//                    .padding(.leading, 30)
//                    .padding(.top, 25)
//                Spacer()
//            }
//            Rectangle()
//                .foregroundStyle(Color(uiColor: .systemGray5))
//                .frame(height: 2)
//                .padding(.top, 5)
//
//            //2nd part
//            HStack(spacing: 14) {
//                ForEach(0..<foodType.count) { index in
//                    Button(action: {
//                        self.selectedIndex_food = index
//                    }) {
//                        Text(foodType[index])
//                            .frame(width: .infinity ,height: 12)
//                            .font(.system(size: 11.5))
//                            .foregroundColor(self.selectedIndex_food == index ? .white : .black)
//                            .padding(.horizontal, 8)
//                            .padding(.vertical, 8)
//                            .background(self.selectedIndex_food == index ? Color(UIColor(hex: "#7F32CD")) : Color.white)
//                            .cornerRadius(15)
//                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
//                    }}
//                Spacer()
//            }.padding(.leading, 30).padding(.top, 15)
//
//
//            HStack(spacing: 10) {
//                Spacer()
//                Button(action: {
//                    dismiss()
//                }) {
//                    Text("Cancel")
//                        .font(.system(size: 14))
//                        .padding(10)
//                        .background(Color(.systemGray3))
//                        .foregroundColor(.black)
//                        .cornerRadius(5)
//
//                }.frame(height: 30)
//                Button(action: {
//                    let newAgePreferences = foodType.enumerated().compactMap { index, age in
//                        selectedIndex_food == index ? age : nil
//                    }
//                    selectedPreferences4 = newAgePreferences
//
//                    dismiss()
//                }) {
//                    Text("Save")
//                        .font(.system(size: 14))
//                        .padding(10)
//                        .background(Color.orange.opacity(0.7))
//                        .foregroundColor(.white)
//                        .fontWeight(.medium)
//                        .cornerRadius(5)
//                }.frame(height: 30)
//
//            }.padding(.trailing, 40).padding(.top, 20).padding(.bottom, 10)
//        }
//    }
//
//}
//
//#Preview {
//    food_sheet(selectedPreferences4: .constant(["Veg"]))
//}
//

//
//// DocumentPicker view
//struct DocumentPicker: UIViewControllerRepresentable {
//    @Binding var url: URL?
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
//        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePlainText), String(kUTTypePDF)], in: .open)
//        picker.allowsMultipleSelection = false
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
//
//    class Coordinator: NSObject, UIDocumentPickerDelegate {
//        var parent: DocumentPicker
//
//        init(parent: DocumentPicker) {
//            self.parent = parent
//        }
//
//        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//            if let url = urls.first {
//                parent.url = url
//            }
//        }
//
//        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//            parent.url = nil
//        }
//    }
//}
// Modify the ImagePicker struct
// Modify the ImagePicker struct


import SwiftUI


struct MenuView: View {
    @StateObject var authService = AuthService.shared
    @State private var menuResponse: MenuResponse?
    
    var body: some View {
        VStack {
            if let menu = menuResponse {
                Text("Breakfast: 1: \(menu.breakfast.option1), 2: \(menu.breakfast.option2)")
                Text("Lunch: 1: \(menu.lunch.option1), 2: \(menu.lunch.option2)")
                Text("Dinner: 1: \(menu.dinner.option1), 2: \(menu.dinner.option2)")
            } else {
                Text("Loading...")
                    .onAppear {
                        authService.fetchTodaysMenuData { response in
                            menuResponse = response
                        }
                    }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

import SwiftUI
import Combine
import UIKit

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .edgesIgnoringSafeArea(keyboardHeight > 0 ? [.bottom] : [])
            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
            }
        
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
