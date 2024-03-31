//
//  MyBookingsView2.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 19/03/24.
//

import SwiftUI


struct MyBookingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTab: Tab = .booking
    @State private var Pg_name: String = "ALR Boys PG"
    @State private var schedule_ID: String = "39882793r2yr8gfdiue28e318"
    @State private var Date_time: String = "19/03/2024 9.00 PM"
    @State private var Booking_ID: String = "200202050"
    @State private var Booking_Date: String = "19-03-2024 9:20 PM"
    @State private var Amount: Int = 50
    
    enum Tab {
        case booking, schedule
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.black)
                            .imageScale(.large)
                            .fontWeight(.semibold)
                    }
                    
                    Text("My Booking")
                        .bold()
                        .foregroundStyle(Color.black)
                        .font(.system(size: 18))
                        .padding(.leading, 30)
                    Spacer()
                }.padding(.leading)
                
                ScrollView {
                    VStack {
                        
                        //Header
                        HStack {
                            
                            Button(action: {
                                selectedTab = .booking
                            }) {
                                Text("Booking")
                                    .fontWeight(.medium)
                                    .foregroundColor(selectedTab == .booking ? Color(UIColor(hex: "#7F32CD")): Color(UIColor(hex: "#5E6278")))
                                    .font(.system(size: 16))
                                    .padding(.leading, 70)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            Button(action: {
                                selectedTab = .schedule
                            }) {
                                Text("Schedule")
                                    .fontWeight(.medium)
                                    .foregroundColor(selectedTab == .schedule ? Color(UIColor(hex: "#7F32CD")) : Color(UIColor(hex: "#5E6278")))
                                    .font(.system(size: 16))
                                    .padding(.trailing, 70)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .frame(height: 50)
                        .background(Color.white)
                        .overlay(
                            GeometryReader { proxy in
                                ZStack(alignment: .bottomLeading) {
                                    Rectangle()
                                        .fill(Color(UIColor(hex: "#7F32CD")))
                                        .frame(width: 70, height: 2) // Adjust width dynamically
                                        .offset(x: selectedTab == .booking ? proxy.size.width / 4 : proxy.size.width / 1.72)
                                        .animation(.easeInOut)
                                }
                                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomLeading)
                            }
                        )
                        
                        //Booking View
                        
                        if selectedTab == .booking {
                            BookingView_profile(Booking_ID: $Booking_ID, Booking_date: $Booking_Date, Ammount: $Amount)
                        } else {
                            VStack {
                                HStack { Text("Upcoming Visits").fontWeight(.medium).font(.system(size: 14))
                                    Spacer()
                                }.padding(.leading).padding(.top, 10)
                                ForEach(0..<3) { index in
                                    ScheduleView_profile(PG_Name: Binding.constant(Pg_name),
                                                         schedule_ID: Binding.constant(schedule_ID),
                                                         date_time: Binding.constant(Date_time))
                                }
                            }
                        }
                    }
                }
                
            }.background(Color(.systemGray6))
        }.navigationBarBackButtonHidden()
    }
}

struct BookingView_profile: View {
    @Binding var Booking_ID: String
    @Binding var Booking_date: String
    @Binding var Ammount: Int
    
    var body: some View {
        VStack {
            
            VStack {
                HStack { Text("Current Bookings").fontWeight(.medium).font(.system(size: 14))
                    Spacer()
                }.padding(.leading).padding(.top, 10)
                
                ForEach(0..<1) { index in 
                    Rectangle()
                        .frame(width: .infinity, height: 70)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                        .overlay (
                            HStack {
                                VStack(alignment: .listRowSeparatorLeading, spacing: 5) {
                                    HStack(spacing: 50) {
                                        Text("Booking ID: \(Booking_ID)")
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                            .font(.system(size: 12.5))
                                        
                                        Text("Amount: \(Ammount)")
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                            .font(.system(size: 12.5))
                                    }
                                    
                                    
                                    Text(Booking_date)
                                        .foregroundColor(.black)
                                        .font(.system(size: 10))
                                    
                                    
                                    Text("Monthly Booking")
                                        .foregroundColor(.black)
                                        .font(.system(size: 11))
                                    
                                    
                                }
                                Spacer()
                            }.padding(.leading, 20)
                        )
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    .padding(.bottom, 10)
                }
            }
            
            VStack {
                HStack { Text("Past Bookings").fontWeight(.medium).font(.system(size: 14))
                    Spacer()
                }.padding(.leading).padding(.top, 10)
                
                ForEach(0..<3) { index in
                    Rectangle()
                        .frame(width: .infinity, height: 70)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                        .overlay (
                            HStack {
                                VStack(alignment: .listRowSeparatorLeading, spacing: 5) {
                                    HStack(spacing: 50) {
                                        Text("Booking ID: \(Booking_ID)")
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                            .font(.system(size: 12.5))
                                        
                                        Text("Amount: \(Ammount)")
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                            .font(.system(size: 12.5))
                                    }
                                    
                                    
                                    Text(Booking_date)
                                        .foregroundColor(.black)
                                        .font(.system(size: 10))
                                    
                                    
                                    Text("Monthly Booking")
                                        .foregroundColor(.black)
                                        .font(.system(size: 11))
                                    
                                    
                                }
                                Spacer()
                            }.padding(.leading, 20)
                        )
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                }
            }
        }
    }
}

struct ScheduleView_profile: View {
    @Binding var PG_Name: String
    @Binding var schedule_ID: String
    @Binding var date_time: String
    
    var body: some View {
        VStack {
            
            
            Rectangle()
                .frame(width: .infinity, height: 70)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 0)
                .overlay (
                    HStack {
                        VStack(alignment: .listRowSeparatorLeading, spacing: 5) {
                            Text(PG_Name)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                                .font(.system(size: 14))
                            
                            HStack {
                                Text("Schedule ID:")
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.system(size: 11))
                                Text(schedule_ID)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
                            }
                            HStack {
                                Text("date and Time:")
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.system(size: 11))
                                Text(date_time)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
                            }
                        }
                        Spacer()
                    }.padding(.leading, 30)
                )
                .padding(.top, 10)
        }
    }
}

#Preview {
    MyBookingsView()
}
