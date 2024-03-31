//
//  AC_buttonsView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 08/03/24.
//

import SwiftUI

struct AC_buttonsView: View {
    let buttonData = [("1 sharing", "₹100"), ("2 sharing", "₹200"), ("3 sharing", "₹300"), ("4 sharing", "₹400"), ("5 sharing", "₹500")]
    let buttonData2 = [("1 sharing", "₹1000"), ("2 sharing", "₹2000"), ("3 sharing", "₹3000"), ("4 sharing", "₹4000"), ("5 sharing", "₹5000")]
    
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
                    ForEach(buttonData.indices, id: \.self) { index in
                        let name = buttonData[index].0
                        let price = buttonData[index].1
                        
                        VStack(spacing: 3) {
                            Text(name)
                                .font(.system(size: 11.5))
                                .foregroundColor(.black)
                            
                            Text(price)
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
            HStack {
                Text("Non - AC")
                    .font(.system(size: 11.5))
                    .bold()
                    .foregroundStyle(Color.black)
                Spacer()
            }.padding(.leading, 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(buttonData2.indices, id: \.self) { index in
                        let name = buttonData2[index].0
                        let price = buttonData2[index].1
                        
                        VStack(spacing: 3) {
                            Text(name)
                                .font(.system(size: 11.5))
                                .foregroundColor(.black)
                            
                            Text(price)
                                .font(.system(size: 11.5))
                                .foregroundColor(.black)
                        }
                        .frame(width: 80, height: 27)
                        .padding(.horizontal, 1)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(lineWidth: 1).foregroundColor(Color(UIColor(hex: "#F25621"))))
                    }
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 5)
                .padding(.bottom, 5)
            }
        }
        .padding(.top, 10)
    }
}

#Preview {
    AC_buttonsView()
}
