//
//  BookingView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 12/03/24.
//

import SwiftUI

struct BookingView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isSheetPresented: Bool
    @State private var isPickerShowing = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    
    let colors = ["Red", "Blue", "Green", "Yellow", "Purple"]
    
    @State private var selectedColor = "Red"
    
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
                Text("Available beds for booking")
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
                PlusMinusBTN2()
            }.padding(.leading).padding(.top, 10)
            
            if isPickerShowing {
                DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                
            }
            
            //3rd part
            DropdownMenu(options: ["Non AC", "AC"])
                .padding(.top, 10)
            DropdownMenu(options: ["Monthly", "Daily", "Yearly"])
                .padding(.top, 5)
            
            //4th part
            SharingButton()
                .padding(.top, 10)
            
            //5th part
            HStack {
                VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                    HStack(spacing: 2) {
                        Text("Total amount (pay at hostel): ₹")
                            .foregroundStyle(Color.black)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                        Text("8500")
                            .foregroundStyle(Color.black)
                            .fontWeight(.regular)
                            .font(.system(size: 16))
                    }
                    HStack(spacing: 2) {
                        Text("Booking amount: ₹")
                            .foregroundStyle(Color.black)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                        Text("50")
                            .foregroundStyle(Color.black)
                            .fontWeight(.regular)
                            .font(.system(size: 16))
                    }
                    HStack(spacing: 2) {
                        Text("Wallet balance: ₹")
                            .foregroundStyle(Color.black)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                        Text("0")
                            .foregroundStyle(Color.black)
                            .fontWeight(.regular)
                            .font(.system(size: 16))
                    }
                }
                Spacer()
            }.padding(.leading).padding(.top, 10)
            
            //last part
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
                    print("Schedule Button tapped!")
                }) {
                    Text("Schedule")
                        .font(.system(size: 14))
                        .padding(10)
                        .background(Color.orange.opacity(0.7))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .cornerRadius(5)
                }.frame(height: 30)
                
            }.padding(.trailing).padding(.top, 10).padding(.bottom, 10)
            
        }
    }
}

#Preview {
    BookingView(isSheetPresented: .constant(true))
}
