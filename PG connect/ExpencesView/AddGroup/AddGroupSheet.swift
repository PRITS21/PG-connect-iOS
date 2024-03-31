//
//  AddGroupView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 24/03/24.
//

import SwiftUI

struct AddGroupSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var isPickerShowing = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var GroupName: String = ""
    
    var body: some View {
        VStack {
            //1st part
            HStack(spacing: 30){
                
                Text("Group Name")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black)
                Spacer()
            }
            
            TextField("Group Name", text: $GroupName)
                .font(.system(size: 14)).frame(height: 30).padding(.leading, 10)
                .background(Color(uiColor: .systemGray6))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                .cornerRadius(5).padding(.bottom, 10).padding(.top, 5)
            
            //2nd part
            HStack(spacing: 5) {
                Rectangle()
                    .frame(width: 40,height: 40).cornerRadius(10)
                    .foregroundStyle(Color(uiColor: .systemGray6))
                    .overlay(
                        Image(uiImage: UIImage(named: "Date_icon")!)
                            .resizable().bold().frame(width: 20, height: 20).imageScale(.large)
                    ).padding(.trailing, 5)
                    .onTapGesture {
                        isPickerShowing.toggle()
                    }
                Rectangle()
                    .frame(width: 40,height: 40).cornerRadius(10)
                    .foregroundStyle(Color(uiColor: .systemGray6))
                    .overlay(
                        Image(uiImage: UIImage(named: "photos_icon")!)
                            .resizable().bold().frame(width: 20, height: 20).imageScale(.large)
                    ).padding(.trailing, 5)
                
                if isPickerShowing {
                    DatePicker("",
                               selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    
                } else {
                    Spacer()
                }
                
            }.padding(.top, 7)
            
            
            
            //3rd part
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
                    print("Schedule Button tapped!")
                }) {
                    Text("Add Group")
                        .font(.system(size: 14))
                        .padding(10)
                        .background(Color(UIColor(hex: "#F25621")))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .cornerRadius(5)
                }.frame(height: 30)
                
            }.padding(.trailing).padding(.top, 10).padding(.bottom, 10)
            
        }.padding(.horizontal, 30)
    }
}


#Preview {
    AddGroupSheet()
}
