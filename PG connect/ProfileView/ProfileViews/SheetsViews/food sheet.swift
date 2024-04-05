//
//  food sheet.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 15/03/24.
//

import SwiftUI

struct food_sheet: View {
    @Binding var selectedPreferences4: [String]
    let foodType = ["veg", "nonveg"]
    @State private var selectedIndex_food: Int? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Food Type")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                    .font(.system(size: 18))
                    .padding(.leading, 30)
                    .padding(.top, 25)
                Spacer()
            }
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray5))
                .frame(height: 2)
                .padding(.top, 5)
            
            //2nd part
            HStack(spacing: 14) {
                ForEach(0..<foodType.count) { index in
                    Button(action: {
                        self.selectedIndex_food = index
                    }) {
                        Text(foodType[index])
                            .frame(width: .infinity ,height: 12)
                            .font(.system(size: 11.5))
                            .foregroundColor(self.selectedIndex_food == index ? .white : .black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(self.selectedIndex_food == index ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                    }}
                Spacer()
            }.padding(.leading, 30).padding(.top, 15)
            
            
            HStack(spacing: 10) {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .font(.system(size: 14))
                        .padding(10)
                        .background(Color(.systemGray3))
                        .foregroundColor(.black)
                        .cornerRadius(5)
                        
                }.frame(height: 30)
                Button(action: {
                    let newfood = foodType.enumerated().compactMap { index, food in
                        selectedIndex_food == index ? food : nil
                    }
                    selectedPreferences4 = newfood
                    var x = print("\(newfood.first!) ** \(selectedPreferences4)")
                                        
                    let userProfile = UserProfile2(foodtype: newfood.first)
                     
                     AuthService.UploadUserData(userProfile: userProfile) { result in
                         switch result {
                         case .success(let data):
                             if let responseData = data {
                                 print("Upload food successful")
                             } else {
                                 print("Upload food successful, but no response data")
                             }
                         case .failure(let error):
                             print("Upload failed with error: \(error.localizedDescription)")
                         }
                     }
                    
                    dismiss()
                }) {
                    Text("Save")
                        .font(.system(size: 14))
                        .padding(10)
                        .background(Color.orange.opacity(0.7))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .cornerRadius(5)
                }.frame(height: 30)
                
            }.padding(.trailing, 40).padding(.top, 20).padding(.bottom, 10)
        }
    }
    
}

#Preview {
    food_sheet(selectedPreferences4: .constant(["Veg"]))
}
