//
//  RentView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 19/03/24.
//

import SwiftUI

struct RentView: View {
    @ObservedObject var viewModel = AuthService.shared
    @Environment(\.dismiss) var dismiss
    @State private var Date: String = "12-12-23"
    @State private var Month: String = "Jan-23"
    @State private var Status_image: String = "Unpaid_icon"
    @State private var Amount: String = "₹2000"
    @State private var Pending: String = "₹1000"
    
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
                    
                    Text("Rent Table")
                        .bold()
                        .foregroundStyle(Color.black)
                        .font(.system(size: 18))
                        .padding(.leading, 30)
                    Spacer()
                }.padding(.leading)
                
                VStack {
                    HStack {
                        Text("Due Date: 12 of Every Month")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 11))
                            
                        Spacer()
                    }
                    
                    VStack {
                        
                        HStack(spacing: 20) {
                            
    
                            Text("Date")
                                .fontWeight(.medium)
                                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                                .font(.system(size: 12.5))
                                //.padding(.leading, 10)
                            
                            Text("Month & Year")
                                .fontWeight(.medium)
                                
                                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                                .font(.system(size: 12.5))
                            
                            Text("status")
                                .fontWeight(.medium)
                                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                                .font(.system(size: 12.5))
                            
                            Text("Amount")
                                .fontWeight(.medium)
                                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                                .font(.system(size: 12.5))
                           
                            Text("Pending Amount")
                                .fontWeight(.medium)
                                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                                .font(.system(size: 12.5))
                                //.padding(.trailing, 10)
                        }.padding(.top, 15)
                        
                        Rectangle()
                            .foregroundStyle(Color(uiColor: .systemGray3))
                            .frame(height: 1.5)
                        
                  
                       
                        ForEach(0..<3) { index in
                            RentViewRows(date: $Date, Month: $Month, Status_image: .constant("Paid_icon"), Amount: $Amount, Pending: $Pending)
                            if index != 2 {
                                Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [4])).frame(height: 1).foregroundColor(.gray)
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                    .padding(.top, 10)
                    
                }.padding(.horizontal).padding(.top, 30)
                
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.fetchRentTable()
        }
    }
}

struct RentViewRows: View {
    @Binding var date: String
    @Binding var Month: String
    @Binding var Status_image: String
    @Binding var Amount: String
    @Binding var Pending: String
    
    
    var body: some View {
        HStack(spacing: 30) {
            
            
            Text(date)
                .fontWeight(.medium)
                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                .font(.system(size: 11))
            //.padding(.leading, 10)
            
            Text(Month)
                .fontWeight(.medium)
            
                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                .font(.system(size: 11))
            
            Image(uiImage: UIImage(named: "\(Status_image)")!)
                .frame(width: 50, height: 19)
            
            Text(Amount)
                .fontWeight(.medium)
                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                .font(.system(size: 11))
            
            Text(Pending)
                .fontWeight(.medium)
                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                .font(.system(size: 11))
            
        }.padding(.top, 5).padding(.bottom)
        
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

#Preview {
    RentView()
}



