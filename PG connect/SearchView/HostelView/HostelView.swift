//
//  HostelView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 07/03/24.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}

struct HostelView: View {
    @Environment(\.dismiss) var dismiss
    @State var activeSheet: ActiveSheet?
    @State private var isScheduleSheetPresented = false
    @State private var isBookSheetPresented = false
    @State private var counterHeight: CGFloat = 220
    @ObservedObject var viewModel = AuthService()
    @State private var pgDetails: PGDetailsResponse?
    var selectedPGData: PGData
    @State private var selectedIndex: String?
   
    init(selectedPGData: PGData) {
        self.selectedPGData = selectedPGData
        
        // Set initial selected index to the first available button name
        if let firstAvailableButton = selectedPGData.roomavailability.availableOptions.first {
            self._selectedIndex = State(initialValue: firstAvailableButton)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // 1st part - Header
                    ZStack(alignment: .center) {
                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.black)
                                    .imageScale(.large)
                                    .bold()
                                    .padding(.leading, 15)
                                Spacer()
                            }
                        }
                        if let details = pgDetails {
                            Text("\(details.pgdata.pgname)")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                        }
                        
                    }.padding(.top, 5).padding(.bottom, 10)
                    
                    // 2nd part - scrollView
                    ScrollView {
                        VStack {
                            if let details = pgDetails {
                                ImageSliderView(imageUrls: details.pgdata.images.map { $0.img })
                                VStack (spacing: 3) {
                                    
                                    HStack {
                                        Text("\(details.pgdata.pgname)")
                                            .font(.system(size: 15))
                                            .bold()
                                            .foregroundStyle(Color.black)
                                        Spacer()
                                    }.padding(.leading).padding(.top, 5)
                                    HStack {
                                        HStack(spacing: 5) {
                                            Image(uiImage: UIImage(named: "location_icon_gray")!)
                                                .resizable()
                                                .frame(width: 12, height: 12)
                                            
                                            Text("\(details.pgdata.city)")
                                                .font(.system(size: 12))
                                                .foregroundStyle(Color.gray)
                                        }
                                        Spacer()
                                    }.padding(.leading)
                                }
                                Rectangle()
                                    .foregroundStyle(Color(uiColor: .systemGray5))
                                    .frame(height: 4)
                                    .padding(.top, 7)
                                
                                HStack {
                                    Text("Type of Sharing")
                                        .font(.system(size: 12.5))
                                        .bold()
                                        .foregroundStyle(Color.black)
                                    Spacer()
                                }.padding(.leading).padding(.top, 2)
                                
                                // Inside HostelView
                                HorizontalButton(buttonNames: details.pgdata.roomavailability.availableOptions) { index in
                                    self.selectedIndex = index
                                }

                                
                                if let selectedIndex = selectedIndex {
                                    switch selectedIndex {
                                    case "Hourly":
                                        if !details.pgdata.rent.hourly.ac.availableOptions.isEmpty {
                                            AC_buttonsView(ButtonDataAC: details.pgdata.rent.hourly.ac.availableOptions)
                                        }
                                        if !details.pgdata.rent.hourly.nonac.availableOptions.isEmpty {
                                            NonAC_buttonsView(ButtonDataNonAC: details.pgdata.rent.hourly.nonac.availableOptions)
                                        }

                                    case "Daily":
                                        if !details.pgdata.rent.daily.ac.availableOptions.isEmpty {
                                            AC_buttonsView(ButtonDataAC: details.pgdata.rent.daily.ac.availableOptions)
                                        }
                                        if !details.pgdata.rent.daily.nonac.availableOptions.isEmpty {
                                            NonAC_buttonsView(ButtonDataNonAC: details.pgdata.rent.daily.nonac.availableOptions)
                                        }

                                    case "Monthly":
                                        if !details.pgdata.rent.monthly.ac.availableOptions.isEmpty {
                                            AC_buttonsView(ButtonDataAC: details.pgdata.rent.monthly.ac.availableOptions)
                                        }
                                        if !details.pgdata.rent.monthly.nonac.availableOptions.isEmpty {
                                            NonAC_buttonsView(ButtonDataNonAC: details.pgdata.rent.monthly.nonac.availableOptions)
                                        }
                                        
                                    default:
                                        var x = print("hola /n")
                                    }
                                }
                                
                                Rectangle()
                                    .foregroundStyle(Color(uiColor: .systemGray5))
                                    .frame(height: 4)
                                    .padding(.top, 5)
                                AmenitiesView(amenities: details.pgdata.amenities)
                                Rectangle()
                                    .foregroundStyle(Color(uiColor: .systemGray5))
                                    .frame(height: 4)
                                    .padding(.top, 5)
                                MapView(locationText: details.pgdata.pgaddress, latitude: Double(details.pgdata.latitude) ?? 0.0, longitude: Double(details.pgdata.longitude) ?? 0.0)

                                Rectangle()
                                    .foregroundStyle(Color(uiColor: .systemGray5))
                                    .frame(height: 4)
                                    .padding(.top, 5)
                                NearbyView(nearbyPlaces: details.pgdata.nearby)
                                Rectangle()
                                    .foregroundStyle(Color(uiColor: .systemGray5))
                                    .frame(height: 4)
                                    .padding(.top, 5)
                                Rules(rules: details.pgdata.rules)
                                
                            }
                        }
                    }
                    
                    // 3rd part - Book Buttons
                    
                    HStack(spacing: 10) {
                        Spacer()
                        Button(action: {
                            print("ScheduleButton tapped!")
                            activeSheet = .first

                        }) {
                            Text("Schedule Visit")
                                .font(.system(size: 14))
                                .padding(10)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }.frame(height: 30)
                        Button(action: {
                            print("Book Button tapped!")
                            activeSheet = .second
                        }) {
                            Text("Book Now")
                                .font(.system(size: 14))
                                .padding(10)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }.frame(height: 30)
                        
                    }.padding(.trailing).padding(.bottom).padding(.top, 2)
                }.background(Color(.systemGray6).opacity(0.5))
               
            }
            .sheet(item: $activeSheet) { item in
                        switch item {
                        case .first:
                            ScheduleView(isSheetPresented: $isScheduleSheetPresented)
                                .presentationDetents([.height(counterHeight)])
                        case .second:
                                BookingView(isSheetPresented: $isBookSheetPresented)
                                    .presentationDetents([.height(550)])
                            
                        }
                    }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            let apiService = AuthService.shared
            apiService.getPGDetailsForUser(selectedPGData._id) { result in
                switch result {
                case .success(let pgDetails):
                    self.pgDetails = pgDetails   // Store the retrieved details
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}





