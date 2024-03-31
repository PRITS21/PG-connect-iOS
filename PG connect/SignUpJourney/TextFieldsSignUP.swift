//
//  TextFields.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 02/03/24.
//

import SwiftUI

struct TextFieldsSignUP: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var state: String
    @Binding var city: String
    @Binding var password: String
    @Binding var confirmPass: String
    @Binding var selectedGenderIndex: Int
    @State private var isSecure1: Bool = true
    @State private var isSecure2: Bool = true
    @State var genderOptions = ["", "Male", "Female", "Other"]
    @State private var errorMessage: String = ""
    @StateObject var viewModel = SignUpViewModel()
    
    
    var body: some View {
        VStack(spacing: 15){
            //Name
            HStack {
                Image(uiImage: UIImage(named: "person_icon")!)
                    .padding(.leading, 10)
                TextField("Full Name", text: $name)
                    .frame(height: 26)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius (10)
                
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
            .padding (.horizontal, 24)
            
            //Email
            HStack {
                Image(uiImage: UIImage(named: "mail_icon")!)
                    .padding(.leading, 10)
                TextField("Email", text: $email)
                    .frame(height: 26)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius (10)
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
            .padding (.horizontal, 24)
            
            //Gender
            HStack {
                Image(systemName: "person.2")
                    .imageScale(.medium)
                    .bold()
                    .foregroundColor(Color(UIColor(hex: "#F25621")))
                    .padding(.leading, 10)
                TextField("Gender", text: .constant(viewModel.gender))
                    .frame(height: 26)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius (10)
                Picker("Gender", selection: $selectedGenderIndex) {
                    ForEach(0..<genderOptions.count, id: \.self) {
                        Text(self.genderOptions[$0])
                            .foregroundStyle(Color.black)
                    }
                }
                .accentColor(.black)
                
            }
            //.frame(height: 50)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
            .padding (.horizontal, 24)


            //Phone Number
            HStack {
                Image(systemName: "phone")
                    .imageScale(.large)
                    .bold()
                    .foregroundColor(Color(UIColor(hex: "#F25621")))
                    .padding(.leading, 10)
                TextField("Phone", text: $phone)
                    .frame(height: 26)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius (10)
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
            .padding (.horizontal, 24)
            
            //City
            HStack {
                Image(systemName: "location")
                    .imageScale(.medium)
                    .bold()
                    .foregroundColor(Color(UIColor(hex: "#F25621")))
                    .padding(.leading, 10)
                TextField("City", text: $city)
                    .frame(height: 26)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius (10)
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
            .padding (.horizontal, 24)
            
            //State
            HStack {
                Image(systemName: "location")
                    .imageScale(.medium)
                    .bold()
                    .foregroundColor(Color(UIColor(hex: "#F25621")))
                    .padding(.leading, 10)
                TextField("State", text: $state)
                    .frame(height: 26)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius (10)
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
            .padding (.horizontal, 24)
            
            //Password
            HStack {
                Image(uiImage: UIImage(named: "password_icon")!)
                    .padding(.leading, 10)
                if isSecure1 {
                    SecureField("Password", text: $password)
                        .frame(height: 26)
                        .font(.subheadline)
                        .padding(12)
                        .cornerRadius (10)
                } else {
                    TextField("Password", text: $password)
                        .frame(height: 26)
                        .font(.subheadline)
                        .padding(12)
                        .cornerRadius (10)
                }
                
                Image(uiImage: UIImage(named: "Eye_icon")!)
                    .padding(.trailing, 15)
                    .imageScale(.large)
                    .onTapGesture {
                        isSecure1.toggle()
                    }
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
            .padding (.horizontal, 24)
            
            //Confirm Password
            HStack {
                Image(uiImage: UIImage(named: "password_icon")!)
                    .padding(.leading, 10)
                if isSecure2 {
                    SecureField("Confirm Password", text: $confirmPass)
                        .frame(height: 26)
                        .font(.subheadline)
                        .padding(12)
                        .cornerRadius (10)
                } else {
                    TextField("Confirm Password", text: $confirmPass)
                        .frame(height: 26)
                        .font(.subheadline)
                        .padding(12)
                        .cornerRadius (10)
                }
                
                Image(uiImage: UIImage(named: "Eye_icon")!)
                    .padding(.trailing, 15)
                    .imageScale(.large)
                    .onTapGesture {
                        isSecure2.toggle()
                    }
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
            .padding (.horizontal, 24)
            


        }
    }

}

#Preview {
    TextFieldsSignUP(name: .constant(""), email: .constant(""), phone: .constant(""), state: .constant(""), city: .constant(""), password: .constant(""), confirmPass: .constant(""), selectedGenderIndex: .constant(0))
}
