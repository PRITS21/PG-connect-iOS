//
//  ScheduleView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 12/03/24.
//

import SwiftUI

struct ScheduleView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isSheetPresented: Bool
    @State private var isPickerShowing = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var value = 1
    @State private var alertItem: AlertItem?

    var pgID: String
    
    
    var body: some View {
        VStack {
            //1st part
            HStack(spacing: 30){
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .bold()
                }
                Text("Schedule Visit")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black)
                Spacer()
            }.padding(.leading)
            
            //2nd part
            HStack(spacing: 20) {
                Rectangle()
                    .frame(width: 150, height: 40)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
                    .overlay(
                        HStack {
                            Image(uiImage: UIImage(named: "Date_icon")!) //Location icon
                                .resizable()
                                .frame(width: 16, height: 16)
                            Text("Date and Time")   //Location Name
                                .foregroundStyle(Color.black)
                                .fontWeight(.regular)
                                .font(.system(size: 16))
                            
                        }.padding(.horizontal, 5)
                    )
                    .onTapGesture {
                        isPickerShowing.toggle()
                    }
                PlusMinusBTN2(value: $value)
            }.padding(.leading).padding(.top, 10)
            
            if isPickerShowing {
                DatePicker("",
                        selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                                
            }
            
            //3rd part
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
                    scheduleVisit()
                    
                    print("Schedule Button tapped!")
                }) {
                    Text("Schedule")
                        .font(.system(size: 14))
                        .padding(10)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .cornerRadius(5)
                }.frame(height: 30)
                
            }.padding(.trailing).padding(.top, 10).padding(.bottom, 10)
            
        }
        .alert(item: $alertItem) { alertItem in // Use alertItem instead of message
                    Alert(title: Text("Schedule Visit"), message: Text(alertItem.message), dismissButton: .default(Text("OK")))
                }
    }
    func scheduleVisit() {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy"
           let dateString = dateFormatter.string(from: selectedDate)
           
           let timeFormatter = DateFormatter()
           timeFormatter.dateFormat = "HH:mm"
           let timeString = timeFormatter.string(from: selectedTime)
           
           let noOfPersons = value
           
           // Call the scheduleVisit function with the appropriate parameters
        AuthService.shared.PostscheduleVisit(pgid: pgID, date: dateString, time: timeString, noofpersons: noOfPersons) { result in
               switch result {
               case .success(let response):
                   print("Schedule visit success: \(response)")
                   self.alertItem = AlertItem(message: response)
                   // Handle success case if needed
               case .failure(let error):
                   print("Schedule visit failure: \(error)")
                   self.alertItem = AlertItem(message: "Failed to schedule visit. Please try again later.")
               }
           }
       }
}



struct PlusMinusBTN2: View {
    @Binding var value: Int // Binding to value variable
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
                    
                }
                .frame(width: 90, height: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.gray))
                .background(Color.white)
                Spacer()
            }
        }
    }
    
}
