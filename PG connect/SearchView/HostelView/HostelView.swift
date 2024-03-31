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
    @State var activeSheet: ActiveSheet?
    @State private var isScheduleSheetPresented = false
    @State private var isBookSheetPresented = false
    @State private var counterHeight: CGFloat = 220
    var fitness: Fitness
    @Environment(\.dismiss) var dismiss
    
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
                        Text(fitness.pgname)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                        
                    }.padding(.top, 5).padding(.bottom, 10)
                    
                    // 2nd part - scrollView
                    ScrollView {
                        VStack {
                           
                            ImageSlideView(fitness: fitness)
                            VStack (spacing: 3) {
                                
                                HStack {
                                    Text(fitness.pgname)
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
                                        
                                        Text(fitness.area)
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
                            
                            HorizontalButton()
                            AC_buttonsView()
                            Rectangle()
                                .foregroundStyle(Color(uiColor: .systemGray5))
                                .frame(height: 4)
                                .padding(.top, 5)
                            AmenitiesView()
                            Rectangle()
                                .foregroundStyle(Color(uiColor: .systemGray5))
                                .frame(height: 4)
                                .padding(.top, 5)
                            MapView(latitude: 22.50108, longitude: 88.36176)
                            Rectangle()
                                .foregroundStyle(Color(uiColor: .systemGray5))
                                .frame(height: 4)
                                .padding(.top, 5)
                            NearbyView()
                            Rectangle()
                                .foregroundStyle(Color(uiColor: .systemGray5))
                                .frame(height: 4)
                                .padding(.top, 5)
                            Rules()
                                
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
        }.navigationBarBackButtonHidden()
    }
}

let sampleFitness = Fitness(id: 0, pgname: "One Hostel", area: "Hyderabad", images: ["room_image 1", "room_image 2", "room_image 3"], startingfrom: "₹2500", roomavailability: "Daily")


#Preview {
    HostelView(fitness: sampleFitness)
}
