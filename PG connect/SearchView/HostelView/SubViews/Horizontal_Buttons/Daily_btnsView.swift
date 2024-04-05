//
//  ButtonsHorizontalViews.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 08/03/24.
//

import SwiftUI

struct HorizontalButton: View {
    @State private var selectedIndex: String?
    let buttonNames: [String]
    let didSelectButton: ((String) -> Void)? // Closure to pass the selected index
    
    init(buttonNames: [String], didSelectButton: ((String) -> Void)?) {
            self.buttonNames = buttonNames
            self.didSelectButton = didSelectButton
            
            // Set initial selected index to the first available button name
            self._selectedIndex = State(initialValue: buttonNames.first)
    }
    var body: some View {
        HStack(spacing: 15) {
            ForEach(buttonNames, id: \.self) { name in
                Button(action: {
                    
                    self.selectedIndex = name
                    didSelectButton?(name)
                }) {
                    Text(name)
                        .frame(width: 45,height: 11)
                        .font(.system(size: 11))
                        .foregroundColor(self.selectedIndex == name ? Color(UIColor(hex: "#7F32CD")) : .black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .background(self.selectedIndex == name ? Color(UIColor(hex: "#7F32CD")).opacity(0.2) : Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(lineWidth: 1).foregroundColor(Color(UIColor(hex: "#7F32CD"))))
                }
            }
            Spacer()
        }
        .padding(.leading)
        .padding(.top, 10) .padding(.bottom, 10)
    }
}

