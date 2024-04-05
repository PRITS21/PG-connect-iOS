//
//  AC_buttonsView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 08/03/24.
//

import SwiftUI

struct AC_buttonsView: View {
    
    let ButtonDataAC: [(String, Int)]
    
    var body: some View {
        VStack (spacing: 5) {
            HStack {
                Text("AC")
                    .font(.system(size: 11.5))
                    .bold()
                    .foregroundStyle(Color.black)
                Spacer()
            }.padding(.leading, 25)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(ButtonDataAC, id: \.0) { sharingOption, price in
                        
                        VStack(spacing: 3) {
                            Text(sharingOption)
                                .font(.system(size: 11.5))
                                .foregroundColor(.black)
                            
                            Text("₹ \(price)")
                                .font(.system(size: 11.5))
                                .foregroundColor(.black)
                        }
                        .frame(width: 80, height: 27)
                        .padding(.horizontal, 1)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(lineWidth: 1).foregroundColor(Color(UIColor(hex: "#7F32CD"))))
                    }
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 5)
                .padding(.bottom, 15)
            }
 
        }
        //.padding(.top, 10)
    }
}

struct NonAC_buttonsView: View {
    
    let ButtonDataNonAC: [(String, Int)]
    
    var body: some View {
        VStack (spacing: 5) {
            HStack {
                Text("Non AC")
                    .font(.system(size: 11.5))
                    .bold()
                    .foregroundStyle(Color.black)
                Spacer()
            }.padding(.leading, 25)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(ButtonDataNonAC, id: \.0) { sharingOption, price in
                        
                        VStack(spacing: 3) {
                            Text(sharingOption)
                                .font(.system(size: 11.5))
                                .foregroundColor(.black)
                            
                            Text("₹ \(price)")
                                .font(.system(size: 11.5))
                                .foregroundColor(.black)
                        }
                        .frame(width: 80, height: 27)
                        .padding(.horizontal, 1)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(lineWidth: 1).foregroundColor(Color(UIColor(hex: "##F25621‎"))))
                    }
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 5)
                .padding(.bottom, 15)
            }
 
        }
       
    }
    
}
