//
//  ProfileView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 04/03/24.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                // 1st part
                Rectangle()
                    .frame(width: .infinity, height: 220)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 100)
                    .shadow(color: Color.gray.opacity(0.2), radius: 2, x: 0, y: 2)
                    .overlay (
                        VStack {
                            Text("Pritam Sarkar")
                                .fontWeight(.medium)
                                .font(.system(size: 18))
                            Image(uiImage: UIImage(named: "QR-code")!)
                                .resizable()
                                .frame(width: 140, height: 140)
                            Text("ID: 65f3adde14c3")
                                .font(.system(size: 12))
                        }
                    )
                    .padding(.top, 25)
                    .padding(.bottom, 10)
                //2nd part
                
                NavigationLink(destination: ProfileEditPage()) {
                    ProfileViewButtons(title: "Profile")
                }
                NavigationLink(destination: RentView()) {
                    ProfileViewButtons(title: "Rent Table")
                }
                NavigationLink(destination: MyBookingsView()) {
                    ProfileViewButtons(title: "My Booking")
                }
                NavigationLink(destination: walletView()) {
                    ProfileViewButtons(title: "Wallet")
                }
                NavigationLink(destination: HelpCenterView()) {
                    ProfileViewButtons(title: "Help Center")
                }
                
                //3rd part
                
                Button {
                    AuthService.shared.clearToken()
                }label: {
                    Text("Log Out")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor(.white)
                        .background( Rectangle()
                            .fill(Color(UIColor(hex: "#7F32CD")))
                            .cornerRadius(10)
                        )
                        .padding(.horizontal)
                        .padding(.top)
                    .shadow(color: Color(UIColor(hex: "#7F32CD")).opacity(0.5), radius: 4, x: 0, y: 3)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .systemGray6).opacity(0.1))
        }
    }
}

struct ProfileViewButtons: View {
    let title: String
    
    var body: some View {
        Rectangle()
            .frame(width: .infinity, height: 50)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .shadow(color: Color.gray.opacity(0.2), radius: 2, x: 0, y: 1)
            .padding(.top, 7)
            .overlay (
                HStack {
                    Text(title)
                        .bold()
                        .foregroundStyle(Color.black)
                        .font(.system(size: 18))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.black)
                        .bold()
                }.padding(.top, 10).padding(.horizontal, 30)
            )
    }
}




#Preview {
    ProfileView()
}
