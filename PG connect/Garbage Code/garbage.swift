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



struct PG_GridView: View {
    @ObservedObject var viewModel = AuthService.shared
    @Binding var selectedCity: String?
    @Binding var selectedFilter: Int?
    @Binding var selectedPGTypeIndex: Int?
    @Binding var searchText: String
    @Binding var selectedIndex2: Int?
    @Binding var minValue: Int
    @Binding var maxValue: Int

    var filteredPGDataCombined: [PGData] {
        // Start with all PG data
        var filteredData = viewModel.pgData
        
        // Filter based on selected city
        if let selectedCity = selectedCity {
            filteredData = filteredData.filter { $0.city == selectedCity }
        }
        
        // Filter based on selected availability (Monthly, Daily, Hourly)
        if let selectedFilter = selectedFilter {
            switch selectedFilter {
            case 0: // Monthly
                filteredData = filteredData.filter { $0.roomavailability.monthly }
            case 1: // Daily
                filteredData = filteredData.filter { $0.roomavailability.daily }
            case 2: // Hourly
                filteredData = filteredData.filter { $0.roomavailability.hourly }
            default:
                break
            }
        }
        
        // Define the PG types array
        let pgTypes = ["male", "female", "coliving"]
        
        // Filter based on selected PG type (male, female, coliving)
        if let selectedPGTypeIndex = selectedPGTypeIndex {
            let selectedPGType = pgTypes[selectedPGTypeIndex]
            filteredData = filteredData.filter { $0.pgtype == selectedPGType }
        }
        
        // Filter based on search text
            if !searchText.isEmpty {
                filteredData = filteredData.filter { $0.pgname.lowercased().contains(searchText.lowercased()) }
            }
        
        
        
        // Define the PG Sharing Options
        let SharingType = ["1 Share", "2 Share", "3 Share", "4 Share", "5+ Share"]

        // Filter based on selected sharing type index
        if let selectedIndex2 = selectedIndex2 {
            let sharingType = SharingType[selectedIndex2]
            // Filter the data based on the selected sharing type
            filteredData = filteredData.filter { pgData in
                // Assuming pgData.roomsharingoptions is an array of Bool values indicating the availability of sharing options
                switch sharingType {
                case "1 Share":
                    return pgData.roomsharingoptions.one
                case "2 Share":
                    return pgData.roomsharingoptions.two
                case "3 Share":
                    return pgData.roomsharingoptions.three
                case "4 Share":
                    return pgData.roomsharingoptions.four
                case "5+ Share":
                    return pgData.roomsharingoptions.five || pgData.roomsharingoptions.six || pgData.roomsharingoptions.seven || pgData.roomsharingoptions.eight || pgData.roomsharingoptions.nine || pgData.roomsharingoptions.ten
                default:
                    return false
                }
            }
        }

        
        return filteredData
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(filteredPGDataCombined) { pgData in
                    NavigationLink(destination: HostelView(selectedPGData: pgData)){
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                            VStack {
                                
                                // Display the RemoteImage if available
                                if let cachedImage = imageCache.object(forKey: pgData.images.first?.img as! NSString) {
                                    Image(uiImage: cachedImage)
                                        .resizable()
                                        .frame(width: .infinity, height: 150)
                                } else {
                                    AsyncImageWithCache(urlString: pgData.images.first?.img ?? "")
                                        .frame(height: 150)
                                }
                                /* Display the RemoteImage if available
                                if let firstImage = pgData.images.first, let url = URL(string: firstImage.img) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(width: .infinity, height: 150)
                                        case .failure:
                                            // Placeholder if image loading fails
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                        case .empty:
                                            // Placeholder while loading
                                            ProgressView()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(height: 150)
                                }*/
                                VStack(spacing: 0) {
                                    HStack {
                                        
                                        Text(pgData.pgname)
                                            .fontWeight(.semibold)
                                            .font(.system(size: 14))
                                        Spacer()
                                    }
                                    HStack {
                                        HStack(spacing: 2) {
                                            Image(uiImage: UIImage(named: "location_icon_gray")!)
                                                .frame(width: 14, height: 14)
                                            Text(pgData.area)
                                                .font(.system(size: 10))
                                        }
                                        Spacer()
                                    }.padding(.bottom, 10)
                                    HStack {
                                        HStack(spacing: 2) {
                                            Text("Avialable: ")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 10))
                                            Text(pgData.roomavailability.availableOptions.joined(separator: " / "))
                                                .font(.system(size: 10))
                                        }
                                        Spacer()
                                    }.padding(.bottom, 7)
                                    HStack {
                                        HStack(spacing: 2) {
                                            Text("Starts from: ")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 10))
                                            Text("₹\(pgData.startingfrom)")
                                                .font(.system(size: 10))
                                        }
                                        Spacer()
                                    }.padding(.bottom, 10)
                                }.padding(.horizontal)
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 4)
                            
                        }
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 5)
        }
        .onAppear {
            viewModel.fetchPGData()
        }
        
    }
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
}



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


