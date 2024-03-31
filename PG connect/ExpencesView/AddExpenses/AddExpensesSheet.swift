//
//  AddExpensesSheet.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 24/03/24.
//

import SwiftUI

struct AddExpensesSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var isPickerShowing = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var Description: String = ""
    @State private var GroupName: String = ""
    @State private var Amount: String = ""
    @State private var Note: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: .infinity,height: 350).cornerRadius(10)
                .foregroundStyle(Color.white).padding(.horizontal)
                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                .overlay(
                    VStack {
                        //1st part
                        HStack(spacing: 30){
                            
                            Text("Add Group Name")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(Color.black)
                            Spacer()
                        }
                        
                        TextField("Enter Description", text: $Description)
                            .font(.system(size: 14)).frame(height: 30).padding(.leading, 10)
                            .background(Color(uiColor: .systemGray6))
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                            .cornerRadius(5).padding(.bottom, 10).padding(.top, 5)
                        
                        //2nd part
                        HStack(spacing: 15) {
                            Rectangle()
                                .frame(width: 35,height: 35).cornerRadius(10)
                                .foregroundStyle(Color.white)
                                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                                .overlay(
                                    Image(uiImage: UIImage(named: "Date_icon")!)
                                        .resizable().bold().frame(width: 20, height: 20).imageScale(.large)
                                ).padding(.trailing, 5)
                                .onTapGesture {
                                    isPickerShowing.toggle()
                                }
                            Rectangle()
                                .frame(width: 35,height: 35).cornerRadius(10)
                                .foregroundStyle(Color.white)
                                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                                .overlay(
                                    Image(uiImage: UIImage(named: "photos_icon")!)
                                        .resizable().bold().frame(width: 20, height: 20).imageScale(.large)
                                ).padding(.trailing, 5)
                            
                            TextField("Group", text: $GroupName)
                                .font(.system(size: 14)).frame(height: 30).padding(.leading, 10)
                                .background(Color(uiColor: .systemGray6))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                                .cornerRadius(5).padding(.bottom, 10).padding(.top, 5)
                            TextField("Amount", text: $Amount)
                                .font(.system(size: 14)).frame(height: 30).padding(.leading, 10)
                                .background(Color(uiColor: .systemGray6))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                                .cornerRadius(5).padding(.bottom, 10).padding(.top, 5)
                            
                            
                        }.padding(.top, 7)
                        
                        if isPickerShowing {
                            
                            DatePicker("",selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                        }
                        
                        TextField("Note", text: $Note, axis: .vertical)
                            .font(.system(size: 14)).frame(height: 60).padding(.leading, 10)
                            .background(Color(uiColor: .systemGray6))
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                            .cornerRadius(5).padding(.bottom, 10).padding(.top, 5)
                        
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
                        
                    }
                    .padding(.horizontal, 30)
                )
        }
    }
}
#Preview {
    AddExpensesSheet()
}
