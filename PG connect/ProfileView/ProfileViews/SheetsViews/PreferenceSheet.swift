//
//  PreferenceSheet.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 15/03/24.
//

import SwiftUI

struct PreferenceSheet: View {
    @State private var existingPreferencesArray: [String] = []

    @Binding var selectedPreferences: [String]
    let AgeGroup = ["20 below", "20-25", "25-30","30-35", "35-40", "40+"]
    let tvGroup = ["Needed", "Not Needed"]
    let EducationGroup = ["AC", "Table","Chair", "Matress","Bed", "Pillow","Shoe Racks","Balcony","Mirror"]
    
    @State private var selectedIndex_Age: Int? = nil
    @State private var selectedIndex_Tv: Int? = nil
    @State private var selectedIndices_edu: Set<Int> = []
    let buttonsPerRow = 5
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Text("Preference")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                    .font(.system(size: 18))
                    .padding(.leading)
                    .padding(.top, 15)
                Spacer()
            }
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray5))
                .frame(height: 2)
                .padding(.top, 5)
            
            //2nd part
            HStack { Text("Age Group") .font(.system(size: 14))
                Spacer()
            }.padding(.leading).padding(.top, 5)
            
            VStack {
                ForEach(0..<AgeGroup.count / buttonsPerRow + 1) { rowIndex in
                    HStack(spacing: 14) {
                        ForEach(0..<min(buttonsPerRow, AgeGroup.count - rowIndex * buttonsPerRow)) { columnIndex in
                            let index = rowIndex * buttonsPerRow + columnIndex
                            Button(action: {
                                self.selectedIndex_Age = index
                                
                            }) {
                                Text(AgeGroup[index])
                                    .frame(width: .infinity, height: 12)
                                    .font(.system(size: 11.5))
                                    .foregroundColor(self.selectedIndex_Age == index ? .white : .black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 8)
                                    .background(self.selectedIndex_Age == index ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                                    .cornerRadius(15)
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                            }
                        }
                        Spacer()
                    }
                }
            }.padding(.leading)
            
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray5))
                .frame(height: 2)
                .padding(.top, 5)
            
            //3rd part
            HStack { Text("Education").bold() .font(.system(size: 14))
                Spacer()
            }.padding(.leading).padding(.top, 5)
            
            VStack {
                ForEach(0..<EducationGroup.count / buttonsPerRow + 1) { rowIndex in
                    HStack(spacing: 14) {
                        ForEach(0..<min(buttonsPerRow, EducationGroup.count - rowIndex * buttonsPerRow)) { columnIndex in
                            let index = rowIndex * buttonsPerRow + columnIndex
                            Button(action: {
                                if self.selectedIndices_edu.contains(index) {
                                    self.selectedIndices_edu.remove(index)
                                } else {
                                    self.selectedIndices_edu.insert(index)
                                }
                            }) {
                                Text(EducationGroup[index])
                                    .frame(width: .infinity, height: 12)
                                    .font(.system(size: 11.5))
                                    .foregroundColor(self.selectedIndices_edu.contains(index) ? .white : .black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 8)
                                    .background(self.selectedIndices_edu.contains(index) ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                                    .cornerRadius(15)
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                            }
                        }
                        Spacer()
                    }
                }
            }.padding(.leading)
            
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray5))
                .padding([.leading, .trailing]).frame(height: 2) .padding(.top, 5)
            
            //4th part
            HStack { Text("TV") .font(.system(size: 14))
                Spacer()
            }.padding(.leading).padding(.top, 5)
            
            HStack(spacing: 14) {
                ForEach(0..<tvGroup.count) { index in
                    Button(action: {
                        self.selectedIndex_Tv = index
                    }) {
                        Text(tvGroup[index])
                            .frame(width: .infinity, height: 12)
                            .font(.system(size: 11.5))
                            .foregroundColor(self.selectedIndex_Tv == index ? .white : .black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(self.selectedIndex_Tv == index ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                    }}
                Spacer()
            }.padding(.leading)
            
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
                    
                    /* ******
                     
                     Error: You have to do -> selectedPreferences = [] to add more buttons
                     
                     ******  */
                    
                    selectedPreferences = []
                    let newAgePreferences = AgeGroup.enumerated().compactMap { index, age in
                        selectedIndex_Age == index ? age : nil
                    }
                    selectedPreferences = newAgePreferences
                    
                    for index in selectedIndices_edu {
                        selectedPreferences.append(EducationGroup[index])
                    }
                    
                    let newTvPreferences = tvGroup.enumerated().compactMap { index, tv in
                        selectedIndex_Tv == index ? tv : nil
                    }
                    selectedPreferences.append(contentsOf: newTvPreferences)
                    
                    let userProfile = UserProfile2(prefrences: selectedPreferences)
                     
                     AuthService.UploadUserData(userProfile: userProfile) { result in
                         switch result {
                         case .success(let data):
                             if let responseData = data {
                                 print("Upload prefrences successful")
                             } else {
                                 print("Upload prefrences successful, but no response data")
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
                
            }.padding(.trailing).padding(.top, 5).padding(.bottom, 10)
        }//.onAppear { selectedPreferences = [] }
    }
}

#Preview {
    PreferenceSheet(selectedPreferences: .constant(["20-25"]))
}
