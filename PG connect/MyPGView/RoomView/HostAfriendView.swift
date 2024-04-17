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
    @State private var EntryDate = Date()
    @State private var ExitDate = Date()
    
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

            VStack (spacing: 20){
                
                DatePicker("Entry Date",selection: $EntryDate, displayedComponents: [.date, .hourAndMinute])
                    .foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 16))
                    .padding(.horizontal).padding(.top, 10)
                DatePicker("Exit Date",selection: $ExitDate, displayedComponents: [.date, .hourAndMinute])
                    .foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 16))
                    .padding(.horizontal).padding(.top, 5)
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
                    Task {
                        do {
                            try await uploadDND2()
                            print("!!!!!!!!")
                        } catch {
                            print("Error from Host Friend : \(error.localizedDescription)")
                        }
                    }
                    print("DND Button Tapped")
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
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    func uploadDND2() async throws {
        do {
            try await AuthService.shared.uploadHost(name: Name, email: email_in, phone: PhoneNumber, entrydate: formattedDate(EntryDate), entrytime: formattedTime(EntryDate), exitdate: formattedDate(ExitDate), exittime: formattedTime(ExitDate)){ result in
                switch result {
                case .success(let message):
                    print("Host data uploaded successfully: \(message)")
                case .failure(let error):
                    print("Error uploading Host data: \(error.localizedDescription)")
                }
            }
        } catch {
            // Handle error
            print("****")
            
        }
    }
}

#Preview {
    HostAFriend()
}
