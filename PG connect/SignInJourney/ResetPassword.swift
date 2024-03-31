//
//  ResetPassword.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 03/03/24.
//

import SwiftUI

struct ResetPassword: View {
    @State var email_Mobile: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .center) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .imageScale(.large)
                                .bold()
                                .padding(.leading, 15)
                            Spacer()
                        }
                    }
                    Text("Reset Password")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                        .padding()
                }
                
                HStack {
                    Text("Enter your Email to request a password request")
                        .font(.system(size: 19))
                        .fontWeight(.regular)
                        .foregroundStyle(Color.black)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.top, 20)
                
                //Email
                HStack {
                    TextField("Email / Mobile", text: $email_Mobile)
                        .frame(height: 30)
                        .font(.subheadline)
                        .padding(12)
                        .cornerRadius (10)
                    Image(uiImage: UIImage(named: "mail_icon")!)
                        .padding(.trailing, 15)
                }
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
                .padding (.horizontal, 24)
                .padding(.top, 30)
                
                NavigationLink(destination: BottomTabView()) {
                    Text("Send")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 25)
                        .foregroundColor(.white)
                        .padding()
                        .background( Rectangle()
                            .fill(Color(UIColor(hex: "#7F32CD")))
                            .cornerRadius(10)
                        )
                }
                .navigationBarBackButtonHidden()
                .padding(.top, 50)
                .padding(.horizontal, 20)
                
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ResetPassword()
}
