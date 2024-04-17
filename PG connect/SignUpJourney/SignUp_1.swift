//
//  SignUp_1.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 02/03/24.
//

import SwiftUI

struct SignUp_1: View {
    @StateObject var viewModel = SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
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
                        Text("Sign Up")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                            
                    }
                    Text("Create account and enjoy all services")
                        .font(.system(size: 21))
                        .fontWeight(.regular)
                        .foregroundStyle(Color.black)
                        .padding()
                    
                    TextFieldsSignUP(name: $viewModel.name, email: $viewModel.email, phone: $viewModel.phone, state: $viewModel.state, city: $viewModel.city, password: $viewModel.password, confirmPass: $viewModel.confirmPass, selectedGenderIndex: $viewModel.selectedGenderIndex)


                    Button(action: {
                       
                        Task {
                            do {
                                try await viewModel.signUp()
                                print("!!!!!!!!")
                            } catch {
                                print("Error from signup : \(error.localizedDescription)")
                            }
                        }
                       
                    }) {
                        Text("Sign Up")
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
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                    .alert(isPresented: Binding<Bool>(
                                    get: { viewModel.errorMessage != "" },
                                    set: { _ in viewModel.errorMessage = "" }
                                )) {
                                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
                                }
                    
                    HStack{
                        Text("Already have an Account ?")
                            .font(.system(size: 16))
                            .fontWeight(.regular)
                            .foregroundStyle(Color.gray)
                        
                        NavigationLink(destination: SignIn_1()) {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(UIColor(hex: "#F25621")))
                            
                        }
                        .navigationBarBackButtonHidden()
                    }
                    .padding(.top, 10)
                    
                    
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $viewModel.isLoggedIn, content: {
                DOBview()
            })
        }
        .navigationBarBackButtonHidden()
    }
}



#Preview {
    SignUp_1()
}
