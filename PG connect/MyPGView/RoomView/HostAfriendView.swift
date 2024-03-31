//
//  HostAfriendView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 23/03/24.
//

import SwiftUI

struct HostAFriend: View {
    @Environment(\.dismiss) var dismiss
    @State private var email_in: String = ""
    @State private var Name: String = ""
    @State private var PhoneNumber: String = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        VStack {
            HStack {
                Text("Host A Friend")
                    .bold()
                    .foregroundStyle(Color.black)
                    .font(.system(size: 14))
                Spacer()
            }.padding(.bottom, 10)
            
            HStack {
                Text("Name")
                    .bold()
                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                    .font(.system(size: 12))
                Spacer()
            }
            TextField("Enter Name", text: $Name)
                .font(.system(size: 14)).frame(height: 30).padding(.leading, 10)
                .background(Color(uiColor: .systemGray6))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                .cornerRadius(5).padding(.bottom, 10)
            
            HStack {
                Text("Email").bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 12))
                Spacer()
            }
            TextField("Enter email", text: $email_in)
                .font(.system(size: 14)).frame(height: 30).padding(.leading, 10)
                .background(Color(uiColor: .systemGray6))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                .cornerRadius(5).padding(.bottom, 10)
            
            HStack {
                Text("Phone Number").bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 12))
                Spacer()
            }
            TextField("Enter Phone Number", text: $PhoneNumber)
                .font(.system(size: 14)).frame(height: 30).padding(.leading, 10)
                .background(Color(uiColor: .systemGray6))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                .cornerRadius(5).padding(.bottom, 10)
            
            HStack  {
                VStack {
                    HStack {
                        Text("Entry Time").bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 12))
                        Spacer()
                    }
                    HStack {
                        DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                            .frame(height: 40)
                            .pickerStyle(SegmentedPickerStyle())
                            .labelsHidden()
                        Spacer()
                    }
                    
                }
                
                VStack {
                    HStack {
                        Text("Exit Time").bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 12))
                        Spacer()
                    }
                    HStack {
                        
                        DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                            .frame(height: 40)
                            .pickerStyle(SegmentedPickerStyle())
                            .labelsHidden()
                        Spacer()
                    }
                    
                }
            }
            
            // save & cancel Part
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
                
            }.padding(.trailing).padding(.top, 35).padding(.bottom, 10)
            
        }.padding(.horizontal).padding(.top, 7)
    }
}

#Preview {
    HostAFriend()
}
