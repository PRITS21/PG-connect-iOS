//
//  Languages sheet.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 15/03/24.
//

import SwiftUI

struct Languages_sheet: View {
    @Binding var selectedPreferences2: [String]
    let MotherToungeLang = ["Telugu", "Hindi", "English", "Tamil", "Kannada"]
    let OthersLang = ["Telugu", "Hindi", "English", "Tamil", "Kannada"]
    
    @State private var selectedIndex_MoT: Int? = nil
    @State private var selectedIndex_OthL: Int? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Language")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                    .font(.system(size: 18))
                    .padding(.leading, 30)
                    .padding(.top, 15)
                Spacer()
            }
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray5))
                .frame(height: 2)
                .padding(.top, 5)
            
            //2nd part
            HStack { Text("Mother Tounge") .font(.system(size: 14))
                Spacer()
            }.padding(.leading, 30).padding(.top, 5)
            
            HStack(spacing: 14) {
                ForEach(0..<MotherToungeLang.count) { index in
                    Button(action: {
                        self.selectedIndex_MoT = index
                    }) {
                        Text(MotherToungeLang[index])
                            .frame(width: .infinity ,height: 12)
                            .font(.system(size: 11.5))
                            .foregroundColor(self.selectedIndex_MoT == index ? .white : .black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(self.selectedIndex_MoT == index ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                    }}
                Spacer()
            }.padding(.leading, 35).padding(.top, 5)
            
            
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray5))
                .frame(height: 2)
                .padding(.top, 5)
            
            //4th part
            HStack { Text("Languages") .font(.system(size: 14))
                Spacer()
            }.padding(.leading, 30).padding(.top, 5)
            
            HStack(spacing: 14) {
                ForEach(0..<OthersLang.count) { index in
                    Button(action: {
                        self.selectedIndex_OthL = index
                    }) {
                        Text(OthersLang[index])
                            .frame(width: .infinity, height: 12)
                            .font(.system(size: 11.5))
                            .foregroundColor(self.selectedIndex_OthL == index ? .white : .black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(self.selectedIndex_OthL == index ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                    }}
                Spacer()
            }.padding(.leading, 35).padding(.top, 5)
            
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
                    let newAgePreferences = MotherToungeLang.enumerated().compactMap { index, age in
                        selectedIndex_MoT == index ? age : nil
                    }
                    selectedPreferences2 = newAgePreferences
                    
                    let newTvPreferences = OthersLang.enumerated().compactMap { index, tv in
                        selectedIndex_OthL == index ? tv : nil
                    }
                    selectedPreferences2.append(contentsOf: newTvPreferences)
                    
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
                
            }.padding(.trailing, 40).padding(.top, 25).padding(.bottom, 10)
        }
    }
    
}

struct Languages_sheet_Previews: PreviewProvider {
    static var previews: some View {
        Languages_sheet(selectedPreferences2: .constant(["Hindi"]))
    }
}
