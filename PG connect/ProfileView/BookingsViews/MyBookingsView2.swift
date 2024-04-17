//
//  MyBookingsView2.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 19/03/24.
//

import SwiftUI


struct MyBookingsView: View {
    @ObservedObject var viewModel = AuthService.shared
    @Environment(\.dismiss) var dismiss
    @State private var selectedTab: Tab = .booking
   
    
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
                            VStack {
                                // Upcoming Visits
                                if let recentbookings = viewModel.bookResponse?.recentbookings, !recentbookings.isEmpty {
                                    HStack {
                                        Text("Current Bookings").fontWeight(.medium).font(.system(size: 14))
                                        Spacer()
                                    }.padding(.leading).padding(.top, 10)
                                    
                                    ForEach(recentbookings) { book in
                                        BookingView_profile(Book: book)
                                    }
                                }else {
                                    Rectangle()
                                        .frame(width: .infinity, height: 70).foregroundColor(.white).cornerRadius(10).padding(.horizontal)
                                        .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 0)
                                        .overlay (
                                            Text("Oops! No Current Bookings Avialable.").fontWeight(.medium).foregroundColor(.black).font(.system(size: 16))).padding(.top)
                                }
                                // Past Visits
                                if let pastbookings = viewModel.bookResponse?.pastbookings, !pastbookings.isEmpty {
                                    HStack {
                                        Text("Past Bookings").fontWeight(.medium).font(.system(size: 14))
                                        Spacer()
                                    }.padding(.leading).padding(.top, 10)
                                    
                                    ForEach(pastbookings) { book in
                                        BookingView_profile(Book: book)
                                    }
                                }
                                
                            }
                        } else {
                            VStack {
                                // Upcoming Visits
                                if let upcomingVisits = viewModel.visitResponse?.upcomingvisits, !upcomingVisits.isEmpty {
                                    HStack {
                                        Text("Upcoming Visits").fontWeight(.medium).font(.system(size: 14))
                                        Spacer()
                                    }.padding(.leading).padding(.top, 10)
                                    
                                    ForEach(upcomingVisits) { visit in
                                        ScheduleView_profile(visit: visit)
                                    }
                                }
                                // Past Visits
                                if let pastVisits = viewModel.visitResponse?.pastvisits, !pastVisits.isEmpty {
                                    HStack {
                                        Text("Past Visits").fontWeight(.medium).font(.system(size: 14))
                                        Spacer()
                                    }.padding(.leading).padding(.top, 10)
                                    
                                    ForEach(pastVisits) { visit in
                                        ScheduleView_profile(visit: visit)
                                    }
                                }
                            }

                        }
                    }
                }
                
            }.background(Color(.systemGray6))
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.fetchScheduleVisit()
        }
        .onAppear {
            viewModel.fetchBookingsData()
        }
    }
}


struct BookingView_profile: View {
    var Book: RecentBooking
    
    var body: some View {
        VStack {
            
            Rectangle()
                .frame(width: .infinity, height: 85)
                .foregroundColor(.white)
                .cornerRadius(10)
            
                .overlay (
                    HStack {
                        VStack(alignment: .listRowSeparatorLeading, spacing: 5) {
                            HStack(spacing: 50) {
                                Text("Booking ID: \(Book._id)")
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .font(.system(size: 12.5))
                                
                                Text("Amount: \(Book.amount)")
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .font(.system(size: 12.5))
                            }
                            
                            Text("\(Book.bookingdate.formattedDate())  \(Book.bookingdate.formattedTime())")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                            
                            Text("\(Book.bookingtype)")
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
}


struct ScheduleView_profile: View {
    var visit: Visit
    
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
                        VStack(alignment: .leading, spacing: 5) {
                            Text(visit.pgid.pgname) // Display PG Name from Visit's pgId
                                .fontWeight(.semibold)
                                .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                                .font(.system(size: 14))
                            
                            HStack {
                                Text("Schedule ID:")
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.system(size: 12))
                                Text(visit._id)
                                    .foregroundColor(.black)
                                    .font(.system(size: 11))
                            }
                            HStack {
                                Text("Date and Time:")
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.system(size: 12))
                                Text("\(visit.dateandtime.formattedDate())  \(visit.dateandtime.formattedTime())")
                                    .foregroundColor(.black)
                                    .font(.system(size: 11))
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
