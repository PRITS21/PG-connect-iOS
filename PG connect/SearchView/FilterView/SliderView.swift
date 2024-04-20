//
//  SliderView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 10/03/24.
//

import SwiftUI

struct SliderView: View {
    @Binding var selectedMinValue: Int
    @Binding var selectedMaxValue: Int
    @State var width: CGFloat = 0
    @State var width1: CGFloat = 0
    var totalWidth: CGFloat = UIScreen.main.bounds.width - 60 // Adjusted total width
    var range: ClosedRange<Int> { // Calculate the range based on width and width1
            let minValue = Int(self.width / self.totalWidth * 10000)
            let maxValue = Int(self.width1 / self.totalWidth * 10000)
            return minValue...maxValue
        }
        
        var minValue: Int {
            return Int(self.width / self.totalWidth * 10000)
        }
        
        var maxValue: Int {
            return Int(self.width1 / self.totalWidth * 10000)
        }
    
    init(selectedMinValue: Binding<Int>, selectedMaxValue: Binding<Int>) {
           // Initialize width and width1 based on the initial values of selectedMinValue and selectedMaxValue
           self._width = State(initialValue: CGFloat(selectedMinValue.wrappedValue) / 10000 * totalWidth)
           self._width1 = State(initialValue: CGFloat(selectedMaxValue.wrappedValue) / 10000 * totalWidth)
           self._selectedMinValue = selectedMinValue
           self._selectedMaxValue = selectedMaxValue
       }
    var body: some View {
        VStack{
            HStack {
                Rectangle()
                    .frame(width: 70, height: 35)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                    .overlay (
                        Text("\(Int(self.width / self.totalWidth * 10000))")
                            .fontWeight(.medium).font(.system(size: 15))
                )
                
                Rectangle()
                    .frame(width: 70, height: 35)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                    .overlay (
                        Text("\(Int(self.width1 / self.totalWidth * 10000))")
                            .fontWeight(.medium).font(.system(size: 15))
                )
                Spacer()
            }.padding(.bottom, 10)
            
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(Color(UIColor(hex: "#7F32CD")).opacity(0.20))
                    .frame(height: 4)
                Rectangle()
                    .fill(Color(UIColor(hex: "#7F32CD")))
                    .frame(width: self.width1 - self.width, height: 6)
                    .offset(x: self.width + 18)
                
                HStack(spacing: 0) {
                    Circle()
                        .fill(Color(UIColor(hex: "#7F32CD")))
                        .frame(width: 18, height: 18)
                        .offset(x: self.width)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                                    let newX = min(max(0, value.location.x), self.width1)
                                    self.width = newX
                                    self.selectedMinValue = Int(newX / self.totalWidth * 10000)

                                })
                        )
                    Circle()
                        .fill(Color(UIColor(hex: "#7F32CD")))
                        .frame(width: 18, height: 18)
                        .offset(x: self.width1)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                                    let newX = min(max(self.width, value.location.x), self.totalWidth)
                                    self.width1 = newX
                                    self.selectedMaxValue = Int(newX / self.totalWidth * 10000)

                                })
                        )
                }
            }
            
        }
        .padding(.horizontal)
    }
}
