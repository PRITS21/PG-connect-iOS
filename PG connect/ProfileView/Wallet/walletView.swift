//
//  walletView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 19/03/24.
//

import SwiftUI

struct walletView: View {
    @ObservedObject var viewModel = AuthService.shared
    @State var BookingAmount: Int = 50
    @State var BookingDate: String = "12-12-2023 10:20PM"
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.black)
                            .imageScale(.large)
                            .fontWeight(.semibold)
                    }
                    
                    Text("Profile")
                        .bold()
                        .foregroundStyle(Color.black)
                        .font(.system(size: 18))
                        .padding(.leading, 30)
                    Spacer()
                }.padding(.leading)
                
                
                //1st part
                ScrollView {
                    VStack {
                        // Balance part
                        Rectangle()
                            .frame(width: .infinity, height: 190)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 70)
                            .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 0)
                            .overlay (
                                VStack(spacing: 15) {
                                    Text("₹\(viewModel.walletResponse?.wallet.balance ?? 10)") // Display the balance
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                                        .font(.system(size: 18))
                                    
                                    Text("Wallet Amount")
                                        .bold()
                                        .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                                        .font(.system(size: 12))
                                }
                            )
                            .padding(.top, 25)
                            .padding(.bottom, 10)
                        
                        Rectangle()
                            .foregroundStyle(Color(uiColor: .systemGray5))
                            .frame(height: 3)
                            .padding(.top, 5)
                        
                        // Transaction part
                        HStack {
                            Text("Transaction")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                            Spacer()
                        }.padding(.leading).padding(.top, 20)
                        Rectangle()
                            .frame(width: .infinity, height: 60)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 7)
                            .overlay (
                                HStack {
                                    VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                                        
                                        Text("Booking Amount: ₹\(viewModel.walletResponse?.wallet.transactions.first?.amount ?? 0)")
                                            .fontWeight(.medium)
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 12))
                                        Text(viewModel.walletResponse?.wallet.transactions.first?.date ?? "")
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 12))
                                        
                                        Spacer()
                                    }.padding(.leading, 20).padding(.top, 10)
                                    Spacer()
                                }
                            )
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color(UIColor(hex: "#F25621"))))
                            .background(Color.white)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        
                    }
                }
            }.background(Color(.systemGray6))
        }
        .navigationBarBackButtonHidden()
            .onAppear {
                        viewModel.fetchWalletData()
                    }
    }
}

#Preview {
    walletView()
}
