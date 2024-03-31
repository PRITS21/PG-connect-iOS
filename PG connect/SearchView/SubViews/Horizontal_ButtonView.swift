//
//  Horizontal_ButtonView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 05/03/24.
//

import SwiftUI

struct Horizontal_ButtonView: View {
    @State private var selectedIndex: Int? = 0
    let buttonNames = ["Near By", "Trending", "Corporate", "Value for Money"]
    var body : some View{
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(0..<buttonNames.count) { index in
                                               
                        if index == 0 {
                            HStack(spacing: 1){
                                Image(uiImage: UIImage(named: "target_icon")!)
                                    .renderingMode(.template)
                                    .resizable()
                                    .imageScale(.large)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(self.selectedIndex == 0 ? .white : Color(UIColor(hex: "#F25621")))
                                
                                Button(action: {
                                    self.selectedIndex = 0
                                }) {
                                    Text(buttonNames[index])
                                        .foregroundColor(self.selectedIndex == 0 ? .white : Color(UIColor(hex: "#F25621")))
                                        
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(self.selectedIndex == 0 ? Color(UIColor(hex: "#F25621")) : Color.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.5).foregroundColor(Color(UIColor(hex: "#F25621"))))
                        } else {
                            
                            Button(action: {
                                self.selectedIndex = index
                            }) {
                                Text(buttonNames[index])
                                    .foregroundColor(self.selectedIndex == index ? .white : Color(UIColor(hex: "#F25621")))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(self.selectedIndex == index ? Color(UIColor(hex: "#F25621")) : Color.white)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.5).foregroundColor(Color(UIColor(hex: "#F25621"))))
                                
                            }
                        }
                    
                }
            }.padding(.leading, 10).padding(.top, 1).padding(.bottom, 5)
        }
        .padding(.top, 10)
        .background(Color(.systemGray6))
    }
    
}

#Preview {
    Horizontal_ButtonView()
}
