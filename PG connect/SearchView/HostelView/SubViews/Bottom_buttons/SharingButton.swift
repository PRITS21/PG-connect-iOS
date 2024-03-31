//
//  SharingButton.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 14/03/24.
//

import SwiftUI

struct SharingButton: View {
    @State private var isFirstRectangleVisible = true
    @State private var isFirstRectangleVisible2 = true

    var body: some View {
        VStack(spacing: 12) {
            if isFirstRectangleVisible {
               
                Button {
                    self.isFirstRectangleVisible = false
                    self.isFirstRectangleVisible2 = true
                } label: {
                    HStack{
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("3 sharing").foregroundColor(.black)
                                .font(.system(size: 14))
                            Text("$ 7500").foregroundColor(.black)
                                .font(.system(size: 14))
                        }
                        
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("Advance").foregroundColor(.black)
                                .font(.system(size: 14))
                            Text("Maintenance").foregroundColor(.black)
                                .font(.system(size: 14))
                        }.padding(.leading, 20)
                        
                        VStack(alignment: .listRowSeparatorLeading){
                            Text(": 500").foregroundColor(.black)
                                .font(.system(size: 14))
                            Text(": 500").foregroundColor(.black)
                                .font(.system(size: 14))
                        }.padding(.leading, 10)
                        
                        HStack {
                            Spacer()
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 62, height: 27)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                                .overlay(Text("+ ADD").foregroundColor(.black).font(.system(size: 14)).fontWeight(.medium))
                                .padding(.trailing, 15)
                            
                        }
                        
                    }.padding(.leading)
                }
                .frame(maxWidth: .infinity, maxHeight: 55).background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    
            } else {
                Button {
                   
                } label: {
                    HStack(spacing: 50) {
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("3 sharing").foregroundColor(.black)
                                .font(.system(size: 14))
                            Text("$ 7500").foregroundColor(.black)
                                .font(.system(size: 14))
                        }.padding(.leading)
                        
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("Advance").foregroundColor(.black)
                                .font(.system(size: 14))
                            Text("Maintenance").foregroundColor(.black)
                                .font(.system(size: 14))
                        }
                        
                        HStack {
                            VStack(alignment: .listRowSeparatorLeading) {
                                Text(": 500").foregroundColor(.black)
                                    .font(.system(size: 14))
                                Text(": 500").foregroundColor(.black)
                                    .font(.system(size: 14))
                            }
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 55)
                .background(Color(UIColor(hex: "#7F32CD")).opacity(0.2))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(UIColor(hex: "#7F32CD")), lineWidth: 1))
            }
            
            if isFirstRectangleVisible2 {
                
                Button {
                    self.isFirstRectangleVisible = true
                    self.isFirstRectangleVisible2 = false
                } label: {
                    HStack{
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("4 sharing").foregroundColor(.black)
                                .font(.system(size: 14))
                            Text("$ 6500").foregroundColor(.black)
                                .font(.system(size: 14))
                        }
                        
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("Advance").foregroundColor(.black)
                                .font(.system(size: 14))
                            Text("Maintenance").foregroundColor(.black)
                                .font(.system(size: 14))
                        }.padding(.leading, 20)
                        
                        VStack(alignment: .listRowSeparatorLeading){
                            Text(": 500").foregroundColor(.black)
                                .font(.system(size: 14))
                            Text(": 500").foregroundColor(.black)
                                .font(.system(size: 14))
                        }.padding(.leading, 10)
                        
                        HStack {
                            Spacer()
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 62, height: 27)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                                .overlay(Text("+ ADD").foregroundColor(.black).font(.system(size: 14)).fontWeight(.medium))
                                .padding(.trailing, 15)
                            
                        }
                        
                    }.padding(.leading)
                }
                .frame(maxWidth: .infinity, maxHeight: 55).background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    
            } else {
                Button {
                   
                } label: {
                    HStack(spacing: 50) {
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("3 sharing").foregroundColor(.black)
                                .font(.system(size: 14))
                            Text("$ 7500").foregroundColor(.black)
                                .font(.system(size: 14))
                        }.padding(.leading)
                        
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text("Advance").foregroundColor(.black)
                                .font(.system(size: 14))
                            Text("Maintenance").foregroundColor(.black)
                                .font(.system(size: 14))
                        }
                        
                        HStack {
                            VStack(alignment: .listRowSeparatorLeading) {
                                Text(": 500").foregroundColor(.black)
                                    .font(.system(size: 14))
                                Text(": 500").foregroundColor(.black)
                                    .font(.system(size: 14))
                            }
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 55)
                .background(Color(UIColor(hex: "#7F32CD")).opacity(0.2))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(UIColor(hex: "#7F32CD")), lineWidth: 1))
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    SharingButton()
}
