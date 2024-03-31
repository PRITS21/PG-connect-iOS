//
//  ButtonsHorizontalViews.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 08/03/24.
//

import SwiftUI

struct HorizontalButton: View {
    @State private var selectedIndex: Int? = 0
    let buttonNames = ["Monthly", "Daily", "Hourly"]
    
    var body: some View {
        HStack(spacing: 15) {
            ForEach(0..<buttonNames.count) { index in
                Button(action: {
                    self.selectedIndex = index
                }) {
                    Text(buttonNames[index])
                        .frame(width: 45,height: 11)
                        .font(.system(size: 11))
                        .foregroundColor(self.selectedIndex == index ? Color(UIColor(hex: "#7F32CD")) : .black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .background(self.selectedIndex == index ? Color(UIColor(hex: "#7F32CD")).opacity(0.2) : Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(lineWidth: 1).foregroundColor(Color(UIColor(hex: "#7F32CD"))))
                }
            }
            Spacer()
        }
        .padding(.leading)
        .padding(.top, 10)
    }
}


#Preview {
    HorizontalButton()
}
