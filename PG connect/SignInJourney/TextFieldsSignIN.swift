//
//  TextFieldsSignIN.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 03/03/24.
//

import SwiftUI

struct TextFieldsSignIN: View {
    @Binding var email_in: String
    @Binding var password_in: String
    @State private var isSecure_in: Bool = true
    
    var body: some View {
        VStack(spacing: 15){
            
            //Email
            HStack {
                Image(uiImage: UIImage(named: "mail_icon")!)
                    .padding(.leading, 10)
                TextField("Email / Mobile", text: $email_in)
                    .frame(height: 30)
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
                if isSecure_in {
                    SecureField("Password", text: $password_in)
                        .frame(height: 30)
                        .font(.subheadline)
                        .padding(12)
                        .cornerRadius (10)
                } else {
                    TextField("Password", text: $password_in)
                        .frame(height: 30)
                        .font(.subheadline)
                        .padding(12)
                        .cornerRadius (10)
                }
                
                Image(uiImage: UIImage(named: "Eye_icon")!)
                    .padding(.trailing, 15)
                    .imageScale(.large)
                    .onTapGesture {
                        isSecure_in.toggle()
                    }
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
            .padding (.horizontal, 24)
            
        }
        .padding(.top, 15)
    }
}


#Preview {
    TextFieldsSignIN(email_in: .constant(""), password_in: .constant(""))
}
