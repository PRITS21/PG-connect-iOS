//
//  DropdownMenu.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 13/03/24.
//

import SwiftUI

struct DropdownMenu: View {
    @State private var isMenuVisible = false
    @Binding var selectedOption: String
    var options: [String]
    
    init(selectedOption: Binding<String>, options: [String] = ["Option 1", "Option 2", "Option 3"]) {
            self._selectedOption = selectedOption
            self.options = options
        }
    
    var body: some View {
        VStack {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(option) {
                        self.selectedOption = option
                        self.isMenuVisible = false
                    }
                }
            } label: {
                HStack {
                    Text(selectedOption)
                        .padding()
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: self.isMenuVisible ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 9, height: 5)
                        .font(Font.system(size: 9, weight: .medium))
                        .foregroundColor(Color.black)
                        .padding(.trailing)
                }
                .background(Color.white)
                .cornerRadius(8)
                .frame(width: .infinity, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
            }
        }
    }
}

