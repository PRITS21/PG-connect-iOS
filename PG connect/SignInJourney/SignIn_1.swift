//
//  SignIn_1.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 03/03/24.
//godsprits21@gmail.com && 12345678

import SwiftUI

struct SignIn_1: View {
    @StateObject var viewModel = SigninViewModel()
    @State private var rememberMe: Bool = false
    @Environment(\.dismiss) var dismiss
    @State private var errorMessage: String = ""
    
    
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
                    Text("Sign In")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    
                }
                
                HStack {
                    Text("Sign In your account")
                        .font(.system(size: 21))
                        .fontWeight(.regular)
                        .foregroundStyle(Color.black)
                        .padding(.top)
                        .padding(.leading)
                    Spacer()
                }
                
                TextFieldsSignIN(email_in: $viewModel.email, password_in: $viewModel.password)
                
                HStack {
                    Toggle(isOn: $rememberMe) {
                        Text("Remember Me")
                            .font(.system(size: 15))
                            .fontWeight(.regular)
                            .foregroundStyle(Color(.systemGray))
                    }
                    .padding(.leading, 30)
                    .toggleStyle(CheckboxToggleStyle())
                    Spacer()
                    NavigationLink(destination: ResetPassword()) {
                        Text("Forgot Password?")
                            .font(.system(size: 13))
                            .fontWeight(.regular)
                            .foregroundColor(.red)
                        
                    }
                    .padding(.trailing, 20)
                }
                .padding(.top, 20)
                
                Button{
                    //Task { try await viewModel.signIn() }
                    Task {
                        do {
                            try await viewModel.signIn()
                            print("!!!!!!!!")
                        } catch {
                            print("Error signing in: \(error.localizedDescription)")
                        }
                    }
                    print("********")
                } label: {
                    Text("Sign In")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 25)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Rectangle()
                                .fill(Color(UIColor(hex: "#7F32CD")))
                                .cornerRadius(10)
                        )
                }
                .navigationBarBackButtonHidden()
                .padding(.top, 50)
                .padding(.horizontal, 20)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
                }
                HStack{
                    Text("Don't have an Account ?")
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundStyle(Color.gray)
                    
                    NavigationLink(destination: SignUp_1()) {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(UIColor(hex: "#F25621")))
                        
                    }
                    .navigationBarBackButtonHidden()
                }
                .padding(.top, 50)
                .padding()
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    SignIn_1()
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                configuration.label
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
