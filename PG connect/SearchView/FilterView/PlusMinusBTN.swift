//
//  PlusMinusBTN.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 10/03/24.
//

import SwiftUI

struct PlusMinusBTN: View {
    @State private var value = 0
    @State private var sameRoomEnabled = false
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button(action: {
                        if self.value > 0 {
                            self.value -= 1
                        }
                    }) {
                        Image(systemName: "minus")
                            .imageScale(.small)
                    }
                    .frame(height: 30)
                    .padding(.trailing, 10)
                    .foregroundColor(.black)
                    //.background(Color.yellow)
                    
                    Text("\(value)")
                        .foregroundColor(.black)
                    
                    Button(action: {
                        self.value += 1
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.small)
                    }
                    .frame(height: 30)
                    .padding(.leading, 10)
                    .foregroundColor(.black)
                    //.background(Color.yellow)
                    //.clipShape(Capsule())
                    
                    
                }
                .frame(width: 120, height: 40)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 1).foregroundColor(.gray))
                .background(Color.white)
                Spacer()
            }
            
            if value > 1 {
                Toggle(isOn: $sameRoomEnabled) {
                    Text("Same Room")
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }.padding(.trailing).toggleStyle(SwitchToggleStyle(tint: .black))
            }
        }
    }
}


struct PlusMinusBTN_Previews: PreviewProvider {
    static var previews: some View {
        PlusMinusBTN()
    }
}
