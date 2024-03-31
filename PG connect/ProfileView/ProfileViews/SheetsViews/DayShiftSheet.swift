//
//  DayShiftSheet.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 15/03/24.
//

import SwiftUI

struct DayShiftSheet: View {
    @Binding var selectedPreferences: [String]
    let ShiftGroup = ["Day shift", "Night shift", "Rotational shift"]
    let daysGroup = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    @State private var selectedIndices_days: Set<Int> = []
    @State private var selectedIndex_Shift: Int? = nil
    @Environment(\.dismiss) var dismiss
    @State private var startTime = Date()
    @State private var endTime = Date()
    let buttonsPerRow = 5
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Text("Working Shift / Days/ Hours")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                    .font(.system(size: 18))
                    .padding(.leading)
                    .padding(.top, 15)
                Spacer()
            }

            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray5))
                .frame(height: 2)
                .padding(.top, 5)
        
            
            //shift part
            HStack { Text("Working shift").bold() .font(.system(size: 14))
                Spacer()
            }.padding(.leading).padding(.top, 5)
            
            HStack(spacing: 14) {
                ForEach(0..<ShiftGroup.count) { index in
                    Button(action: {
                        self.selectedIndex_Shift = index
                    }) {
                        Text(ShiftGroup[index])
                            .frame(width: .infinity, height: 12)
                            .font(.system(size: 11.5))
                            .foregroundColor(self.selectedIndex_Shift == index ? .white : .black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(self.selectedIndex_Shift == index ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                    }}
                Spacer()
            }.padding(.leading).padding([.top, .bottom], 5)
            
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray5))
                .frame(height: 2)
                .padding(.top, 5)
            
            //Days part
            HStack { Text("Working Days").bold() .font(.system(size: 14))
                Spacer()
            }.padding(.leading).padding(.top, 5)

            VStack {
                ForEach(0..<daysGroup.count / buttonsPerRow + 1) { rowIndex in
                    HStack(spacing: 14) {
                        ForEach(0..<min(buttonsPerRow, daysGroup.count - rowIndex * buttonsPerRow)) { columnIndex in
                            let index = rowIndex * buttonsPerRow + columnIndex
                            Button(action: {
                                if self.selectedIndices_days.contains(index) {
                                    self.selectedIndices_days.remove(index)
                                } else {
                                    self.selectedIndices_days.insert(index)
                                }
                            }) {
                                Text(daysGroup[index])
                                    .frame(width: .infinity, height: 12)
                                    .font(.system(size: 11.5))
                                    .foregroundColor(self.selectedIndices_days.contains(index) ? .white : .black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 8)
                                    .background(self.selectedIndices_days.contains(index) ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                                    .cornerRadius(15)
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                            }
                        }
                        Spacer()
                    }
                }
            }.padding(.leading)
            
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray5))
                .padding([.leading, .trailing]).frame(height: 2) .padding(.top, 5)
            
            //Hours part
            HStack { Text("Working Hours").bold() .font(.system(size: 14))
                Spacer()
            }.padding(.leading).padding(.top, 5)
            
            HStack {
                
                DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    .frame(height: 40)
                    .pickerStyle(SegmentedPickerStyle())
                    .labelsHidden()
                
                Text("To")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                DatePicker("Start Time", selection: $endTime, displayedComponents: .hourAndMinute)
                    .pickerStyle(SegmentedPickerStyle())
                    .labelsHidden()
                Spacer()
            }
            .padding(.leading)
            .padding(.top, 10)
            
            // save & cancel Part
            HStack(spacing: 10) {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .font(.system(size: 14))
                        .padding(10)
                        .background(Color(.systemGray3))
                        .foregroundColor(.black)
                        .cornerRadius(5)
                }.frame(height: 30)
                Button(action: {
                    
                    /* ******
                     
                     Error: You have to do -> selectedPreferences = [] to add more buttons
                     
                     ******  */
                    
                    selectedPreferences = []
                    let newAgePreferences = ShiftGroup.enumerated().compactMap { index, age in
                        selectedIndex_Shift == index ? age : nil
                    }
                    selectedPreferences = newAgePreferences
                    
                    for index in selectedIndices_days {
                        selectedPreferences.append(daysGroup[index])
                    }
                    
                    dismiss()
                }) {
                    Text("Save")
                        .font(.system(size: 14))
                        .padding(10)
                        .background(Color.orange.opacity(0.7))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .cornerRadius(5)
                }.frame(height: 30)
                
            }.padding(.trailing).padding(.top, 5).padding(.bottom, 10)
        }
    }
}

#Preview {
    DayShiftSheet(selectedPreferences: .constant(["Day Shift"]))
}
