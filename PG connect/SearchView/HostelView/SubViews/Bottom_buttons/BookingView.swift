//
//  BookingView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 12/03/24.
//

import SwiftUI
import Razorpay

class RazorpayPaymentHandler: ObservableObject, RazorpayPaymentCompletionProtocolWithData {
    @Published var paymentResult: String = ""
    @Published var paymentError: Error?

    // This method is called when payment is successful
    func onPaymentSuccess(_ payment_id: String?, andData response: [AnyHashable : Any]?) {
        paymentResult = "Payment successful. Payment ID: \(payment_id ?? "")"
    }

    // This method is called when payment fails
    func onPaymentError(_ code: Int32, description str: String?, andData response: [AnyHashable : Any]?) {
        paymentError = NSError(domain: "RazorpayErrorDomain", code: Int(code), userInfo: [NSLocalizedDescriptionKey: str ?? ""])
    }
}

class RazorpayPaymentHandler2: ObservableObject, RazorpayPaymentCompletionProtocolWithData {
    @Published var paymentResult: String = ""
    @Published var paymentError: Error?

    // This method is called when payment is successful
    func onPaymentSuccess(_ payment_id: String?, andData response: [AnyHashable : Any]?) {
        paymentResult = "Payment successful. Payment ID: \(payment_id ?? "")"
        
        // Accessing booking time and transaction time if available
        if let bookingTime = response?["booking_time"] as? String,
           let transactionTime = response?["transaction_time"] as? String {
            // Do something with bookingTime and transactionTime
            print("Booking Time: \(bookingTime), Transaction Time: \(transactionTime)")
        }
    }

    // This method is called when payment fails
    func onPaymentError(_ code: Int32, description str: String?, andData response: [AnyHashable : Any]?) {
        paymentError = NSError(domain: "RazorpayErrorDomain", code: Int(code), userInfo: [NSLocalizedDescriptionKey: str ?? ""])
    }
}
struct BookingView: View {
    @StateObject var razorpayHandler = RazorpayPaymentHandler2()
    var pgData: PGDetailsResponse
    @Environment(\.dismiss) var dismiss
    @Binding var isSheetPresented: Bool
    @State private var isPickerShowing = false
    @State private var value = 1
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var selectedSession1 = "Non AC"
    @State private var selectedSession2 = "Monthly"
    @State var session1Options: [String] = []
    @State var session2Options: [String] = []
    @State private var selectedSharing: String?
    @State var razorpayOrder: RazorpayOrder?
    
    private var options: (session1: [String], session2: [String]) {
        var session1Options: [String] = []
        var session2Options: [String] = []
        
        
        // Check for Non AC options in Monthly, Daily, and Hourly bookings
        if pgData.bookingsallowed.monthly.nonac.onesharing || pgData.bookingsallowed.monthly.nonac.twosharing || pgData.bookingsallowed.monthly.nonac.threesharing || pgData.bookingsallowed.monthly.nonac.foursharing || pgData.bookingsallowed.monthly.nonac.fivesharing || pgData.bookingsallowed.monthly.nonac.sixsharing {
            session1Options.append("Non AC")
        }
        if pgData.bookingsallowed.daily.nonac.onesharing || pgData.bookingsallowed.daily.nonac.twosharing || pgData.bookingsallowed.daily.nonac.threesharing || pgData.bookingsallowed.daily.nonac.foursharing || pgData.bookingsallowed.daily.nonac.fivesharing || pgData.bookingsallowed.daily.nonac.sixsharing {
            session1Options.append("Non AC")
        }
        if pgData.bookingsallowed.hourly.nonac.onesharing || pgData.bookingsallowed.hourly.nonac.twosharing || pgData.bookingsallowed.hourly.nonac.threesharing || pgData.bookingsallowed.hourly.nonac.foursharing || pgData.bookingsallowed.hourly.nonac.fivesharing || pgData.bookingsallowed.hourly.nonac.sixsharing {
            session1Options.append("Non AC")
        }
        
        // Check for AC options in Monthly, Daily, and Hourly bookings
        if pgData.bookingsallowed.monthly.ac.onesharing || pgData.bookingsallowed.monthly.ac.twosharing || pgData.bookingsallowed.monthly.ac.threesharing || pgData.bookingsallowed.monthly.ac.foursharing || pgData.bookingsallowed.monthly.ac.fivesharing || pgData.bookingsallowed.monthly.ac.sixsharing {
            session1Options.append("AC")
        }
        if pgData.bookingsallowed.daily.ac.onesharing || pgData.bookingsallowed.daily.ac.twosharing || pgData.bookingsallowed.daily.ac.threesharing || pgData.bookingsallowed.daily.ac.foursharing || pgData.bookingsallowed.daily.ac.fivesharing || pgData.bookingsallowed.daily.ac.sixsharing {
            session1Options.append("AC")
        }
        if pgData.bookingsallowed.hourly.ac.onesharing || pgData.bookingsallowed.hourly.ac.twosharing || pgData.bookingsallowed.hourly.ac.threesharing || pgData.bookingsallowed.hourly.ac.foursharing || pgData.bookingsallowed.hourly.ac.fivesharing || pgData.bookingsallowed.hourly.ac.sixsharing {
            session1Options.append("AC")
        }
        
        // Check for Monthly options
        if pgData.bookingsallowed.monthly.nonac.onesharing || pgData.bookingsallowed.monthly.nonac.twosharing || pgData.bookingsallowed.monthly.nonac.threesharing || pgData.bookingsallowed.monthly.nonac.foursharing || pgData.bookingsallowed.monthly.nonac.fivesharing || pgData.bookingsallowed.monthly.nonac.sixsharing {
            session2Options.append("Monthly")
        }
        if pgData.bookingsallowed.monthly.ac.onesharing || pgData.bookingsallowed.monthly.ac.twosharing || pgData.bookingsallowed.monthly.ac.threesharing || pgData.bookingsallowed.monthly.ac.foursharing || pgData.bookingsallowed.monthly.ac.fivesharing || pgData.bookingsallowed.monthly.ac.sixsharing {
            session2Options.append("Monthly")
        }
        
        // Check for Daily options
        if pgData.bookingsallowed.daily.nonac.onesharing || pgData.bookingsallowed.daily.nonac.twosharing || pgData.bookingsallowed.daily.nonac.threesharing || pgData.bookingsallowed.daily.nonac.foursharing || pgData.bookingsallowed.daily.nonac.fivesharing || pgData.bookingsallowed.daily.nonac.sixsharing {
            session2Options.append("Daily")
        }
        if pgData.bookingsallowed.daily.ac.onesharing || pgData.bookingsallowed.daily.ac.twosharing || pgData.bookingsallowed.daily.ac.threesharing || pgData.bookingsallowed.daily.ac.foursharing || pgData.bookingsallowed.daily.ac.fivesharing || pgData.bookingsallowed.daily.ac.sixsharing {
            session2Options.append("Daily")
        }
        
        // Check for Hourly options
        if pgData.bookingsallowed.hourly.nonac.onesharing || pgData.bookingsallowed.hourly.nonac.twosharing || pgData.bookingsallowed.hourly.nonac.threesharing || pgData.bookingsallowed.hourly.nonac.foursharing || pgData.bookingsallowed.hourly.nonac.fivesharing || pgData.bookingsallowed.hourly.nonac.sixsharing {
            session2Options.append("Hourly")
        }
        if pgData.bookingsallowed.hourly.ac.onesharing || pgData.bookingsallowed.hourly.ac.twosharing || pgData.bookingsallowed.hourly.ac.threesharing || pgData.bookingsallowed.hourly.ac.foursharing || pgData.bookingsallowed.hourly.ac.fivesharing || pgData.bookingsallowed.hourly.ac.sixsharing {
            session2Options.append("Hourly")
        }
        
        print("Session 1 Options: \(session1Options)")
        print("Session 2 Options: \(session2Options)")
        // Return the populated arrays
        return (session1Options, session2Options)
    }
    
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
                Text("\(pgData.pgdata.pgname)")
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
                DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                
            }
            
            
            
            // 3rd part
            DropdownMenu(selectedOption: $selectedSession1, options: session1Options)
                .padding(.top, 10)
            DropdownMenu(selectedOption: $selectedSession2, options: session2Options)
                .padding(.top, 5)
            
            var selectedRentOptions: [(String, Int)] {
                if selectedSession1 == "Non AC" {
                    switch selectedSession2 {
                    case "Monthly":
                        return pgData.pgdata.rent.monthly.nonac.availableOptions
                    case "Daily":
                        return pgData.pgdata.rent.daily.nonac.availableOptions
                    case "Hourly":
                        return pgData.pgdata.rent.hourly.nonac.availableOptions
                    default:
                        return []
                    }
                } else {
                    switch selectedSession2 {
                    case "Monthly":
                        return pgData.pgdata.rent.monthly.ac.availableOptions
                    case "Daily":
                        return pgData.pgdata.rent.daily.ac.availableOptions
                    case "Hourly":
                        return pgData.pgdata.rent.hourly.ac.availableOptions
                    default:
                        return []
                    }
                }
            }
            
            var otherOptions: [(String, Int)] {
                if selectedSession1 == "Non AC" {
                    switch selectedSession2 {
                    case "Monthly":
                        return pgData.pgdata.rent.monthly.nonac.otherOptions
                    case "Daily":
                        return pgData.pgdata.rent.daily.nonac.otherOptions
                    case "Hourly":
                        return pgData.pgdata.rent.hourly.nonac.otherOptions
                    default:
                        return []
                    }
                } else {
                    switch selectedSession2 {
                    case "Monthly":
                        return pgData.pgdata.rent.monthly.ac.otherOptions
                    case "Daily":
                        return pgData.pgdata.rent.daily.ac.otherOptions
                    case "Hourly":
                        return pgData.pgdata.rent.hourly.ac.otherOptions
                    default:
                        return []
                    }
                }
            }
            
            
            
            var y = print(selectedSession1 == "Non AC" ? "\(pgData.bookingsallowed.monthly.nonac)" : "\(pgData.bookingsallowed.monthly.ac)")
            
            //4th part
            SharingButton(ButtonDataAC: selectedRentOptions, otherOptions: otherOptions, bookingsAllowed: pgData.bookingsallowed.monthly.nonac, selectedSharingOption: $selectedSharing)
        
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
                        Text("\(razorpayOrder?.razorpayorder.amount ?? 10)")
                            .foregroundStyle(Color.black)
                            .fontWeight(.regular)
                            .font(.system(size: 16))
                    }
                    HStack(spacing: 2) {
                        Text("Wallet balance: ₹")
                            .foregroundStyle(Color.black)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                        Text("\(AuthService.shared.walletResponse?.wallet.balance ?? 10)")
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
                    print("Book Button tapped: \(selectedSharing)")
                    dismiss()
                    createRazorPayOrder()
                }) {
                    Text("Book")
                        .font(.system(size: 14))
                        .padding(10)
                        .background(Color.orange.opacity(0.7))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .cornerRadius(5)
                }.frame(height: 30)
                
            }.padding(.trailing).padding(.top, 10).padding(.bottom, 10)
            
        }
        .onAppear {
            // Set the session options arrays when the view appears
            (session1Options, session2Options) = options
        }
        .onAppear { AuthService.shared.fetchWalletData() }
    }
    //MARK: POST API call
    func createRazorPayOrder() {
        let pgid = pgData.pgdata._id
        //let bookingType = selectedSession2
        let roomType = selectedSession1 == "Non AC" ? "nonac" : "ac"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let bookingDate = dateFormatter.string(from: selectedDate)
        dateFormatter.dateFormat = "HH:mm"
        let bookingTime = dateFormatter.string(from: selectedTime)
        let beds = value
        let useWallet = true
        
        var sharingType = ""
            switch selectedSharing {
                case "1 sharing":
                    sharingType =  "one"
                case "2 sharing":
                    sharingType = "two"
                case "3 sharing":
                    sharingType =  "three"
                case "4 sharing":
                    sharingType = "four"
                case "5 sharing":
                    sharingType = "five"
                default:
                    break
            }
        var bookingType = ""
            switch selectedSession2 {
            case "Monthly":
                bookingType = "monthly"
            case "Daily":
                bookingType = "daily"
            case "Hourly":
                bookingType = "hourly"
            default:
                break
            }
        
        AuthService.shared.createRazorPayOrderForBooking(pgid: pgid, bookingType: bookingType, roomType: roomType, sharingType: sharingType, bookingDate: bookingDate, bookingTime: bookingTime, beds: beds, useWallet: useWallet) { result in
            switch result {
            case .success(let response):
                print("RazorPay order created successfully: \(response)")
                self.razorpayOrder = response
                initiatePayment()
            case .failure(let error):
                print("Failed to create RazorPay order: \(error)")
            }
        }
    }
    //MARK: Function for payment
    func initiatePayment() {
        var options = [
            "amount": razorpayOrder?.razorpayorder.amount as Any,
            "currency": "INR",
            "description": "Payment for booking",
            "image": "https://pgplanner.com/images/pg-planner-logo.png",
            "name": pgData.pgdata.pgname,
            "prefill": [
                "contact": "8423695124",
                "email": "testuser@gmail.com"
            ],
            "theme": [
                "color": "#7F32CD"
            ]
        ] as [String : Any]
        
        let razorPay = RazorpayCheckout.initWithKey("rzp_test_MenI4SmE1LBTMw", andDelegate: razorpayHandler)
        razorPay.open(options)
    }
}

import SwiftUI

struct SharingButton: View {
    let ButtonDataAC: [(String, Int)]
    let otherOptions: [(String, Int)]
    let bookingsAllowed: BookingsDetails
    @State private var selectedIndex: Int? = nil
    @Binding var selectedSharingOption: String?

    var body: some View {
        VStack {
            ForEach(ButtonDataAC.indices, id: \.self) { index in
                let (sharingOption, price) = ButtonDataAC[index]
                if isSharingAllowed(sharingOption: sharingOption) {
                    Button(action: {
                        if selectedIndex == index {
                            selectedIndex = nil
                            selectedSharingOption = nil
                        } else {
                            selectedIndex = index
                            selectedSharingOption = sharingOption
                        }
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(sharingOption)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                                Text("₹ \(price)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                            }
                            .padding(.leading)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Maintenance")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                                Text("Advance")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                ForEach(otherOptions.indices, id: \.self) { index in
                                    let (optionTitle, optionPrice) = otherOptions[index]
                                    Text("\(optionPrice)")
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                }
                            }
                            Spacer()
                            if selectedIndex != index {
                                HStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .frame(width: 62, height: 27)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                                        .overlay(Text("+ ADD").foregroundColor(.black).font(.system(size: 14)).fontWeight(.medium))
                                        .padding(.trailing, 15)
                                }
                            }
                        }.frame(width: .infinity, height: 55)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(selectedIndex == index ? Color(UIColor(hex: "#7F32CD")).opacity(0.2) : Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(selectedIndex == index ? Color(UIColor(hex: "#7F32CD")) : Color.gray, lineWidth: 1))
                }
            }
        }
        .padding(.horizontal)
    }
    
    func isSharingAllowed(sharingOption: String) -> Bool {
        let allowed: Bool
        switch sharingOption {
        case "1 sharing":
            allowed = bookingsAllowed.onesharing
        case "2 sharing":
            allowed = bookingsAllowed.twosharing
        case "3 sharing":
            allowed = bookingsAllowed.threesharing
        case "4 sharing":
            allowed = bookingsAllowed.foursharing
        case "5 sharing":
            allowed = bookingsAllowed.fivesharing
        case "6 sharing":
            allowed = bookingsAllowed.sixsharing
        case "7 sharing":
            allowed = bookingsAllowed.sevensharing
        case "8 sharing":
            allowed = bookingsAllowed.eightsharing
        case "9 sharing":
            allowed = bookingsAllowed.ninesharing
        case "10 sharing":
            allowed = bookingsAllowed.tensharing
        default:
            allowed = false
        }
        return allowed
    }
    
}
