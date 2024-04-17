//
//  D_O_B.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 03/03/24.
//

import SwiftUI

struct DOBview: View {
    @State private var birthday = Date()
    @Environment(\.dismiss) var dismiss
    @State private var isDatePickerVisible = false
    @State private var buttonText = "Select DOB"
    @State private var isDOBUploaded = false // Track if DOB is uploaded

    var body: some View {
        NavigationView {
            VStack {
                Text("Select your Date of Birth ?")
                    .font(.system(size: 21))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black)
                    .padding(.top, 50)
                    .padding(.leading)
                
                //DOB button
                Button(action: {
                    isDatePickerVisible.toggle()
                }) {
                    HStack {
                        Text(buttonText)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                            .padding()
                        Image(systemName: isDatePickerVisible ? "chevron.up" : "chevron.down")
                            .foregroundColor(.black)
                            .imageScale(.medium)
                            .bold()
                            .padding(.trailing,8)
                    }
                }
                .frame(width: 170, height: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
                .padding(.top, 70)
                
                // Date picker
                if isDatePickerVisible {
                    DatePicker("", selection: $birthday, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .padding()
                        .onChange(of: birthday) { 
                            buttonText = "\(formatDate(birthday))"
                        }
                }
                
                
                Spacer()
                
                HStack {
                    //Back button
                    Button { dismiss() } label: {
                        HStack {
                            Image(uiImage: UIImage(named: "backBTN")!)
                                .imageScale(.large)
                                .bold()
                                .padding(.leading, 15)
                        }
                    }
                    Spacer()
                    //Next button
                    Button(action: {
                        AuthService.shared.uploadDOB(dob: birthday.formattedDate2()) { result in
                            switch result {
                            case .success(_):
                                print("DOB uploaded successfully")
                                isDOBUploaded = true
                            case .failure(let error):
                                print("Error uploading DOB: \(error.localizedDescription)")
                            }
                        }
                    }) {
                        Image(uiImage: UIImage(named: "nextBTN")!)
                            .imageScale(.large)
                            .bold()
                            .padding(.trailing, 15)
                    }
                }
            }
            .fullScreenCover(isPresented: $isDOBUploaded, content: {
                BottomTabView()
            })
        }
        .navigationBarBackButtonHidden()
        
    }
    
    // Helper function to format the date
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }

}

#Preview {
    DOBview()
}
