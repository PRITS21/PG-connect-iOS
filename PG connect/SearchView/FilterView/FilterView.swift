//
//  FilterView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 10/03/24.
//

import SwiftUI

struct FilterView: View {
    //@State private var selectedIndex: Int? = nil
    @Binding var selectedIndex: Int?
    @Binding var selectedIndices_PG: Int?
    let buttonNames = ["Monthly", "Daily", "Hourly"]
    let PGType = ["Boys", "Girls", "Co-living"]
    let SharingType = ["1 Share", "2 Share", "3 Share", "4 Share", "5+ Share"]
    @Binding var selectedIndex2: Int?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            // 1st Part
            HStack {
                Text("Filters")
                    .bold()
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                }
            }.padding([.leading, .trailing]).padding(.bottom, 10).padding(.top, 20)
            
            //2nd Part
            ScrollView {
                
                VStack(spacing: 15) {
                    
                    //Daily Buttons
                    HStack { Text("Types of Availability") .font(.system(size: 14))
                        Spacer()
                    }.padding(.leading).padding(.top, 10)
                    
                    HStack(spacing: 15) {
                        ForEach(0..<buttonNames.count) { index in
                            Button(action: {
                                if self.selectedIndex == index {
                                    self.selectedIndex = nil
                                } else {
                                    self.selectedIndex = index
                                }
                            }) {
                                Text(buttonNames[index])
                                    .frame(width: 45,height: 12)
                                    .font(.system(size: 11.5))
                                    .foregroundColor(self.selectedIndex == index ? .white : .black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 8)
                                    .background(self.selectedIndex == index ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                                    .cornerRadius(15)
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                            }}
                        Spacer()
                    }.padding(.leading)
                    
                    Rectangle()
                        .foregroundStyle(Color(uiColor: .systemGray5))
                        .padding([.leading, .trailing]).frame(height: 2).padding(.top, 5)
                    
                    //Rent
                    HStack { Text("Rent") .font(.system(size: 14))
                        Spacer()
                    }.padding(.leading).padding(.top, 5)
                    
                    SliderView()
                        .padding([.leading, .trailing])
                    
                    Rectangle()
                        .foregroundStyle(Color(uiColor: .systemGray5))
                        .padding([.leading, .trailing]).frame(height: 2) .padding(.top, 5)
                    
                    //Type of PG
                    HStack { Text("Types of PG") .font(.system(size: 14))
                        Spacer()
                    }.padding(.leading).padding(.top, 5)
                    
                    HStack(spacing: 15) {
                        ForEach(0..<PGType.count) { index in
                            Button(action: {
                                if self.selectedIndices_PG == index {
                                    self.selectedIndices_PG = nil
                                } else {
                                    self.selectedIndices_PG = index
                                }
                            }) {
                                Text(PGType[index])
                                    .frame(width: .infinity, height: 12)
                                    .font(.system(size: 11.5))
                                    .foregroundColor(self.selectedIndices_PG == index ? .white : .black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 8)
                                    .background(self.selectedIndices_PG == index ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                                    .cornerRadius(15)
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                            }}
                        Spacer()
                    }.padding(.leading)
                    
                    Rectangle()
                        .foregroundStyle(Color(uiColor: .systemGray5))
                        .padding([.leading, .trailing]).frame(height: 2) .padding(.top, 5)
                    
                    // Sharing type
                    HStack { Text("Types of Sharing") .font(.system(size: 14))
                        Spacer()
                    }.padding(.leading).padding(.top, 5)
                    
                    HStack(spacing: 14) {
                        ForEach(0..<SharingType.count) { index in
                            Button(action: {
                                if self.selectedIndex2 == index {
                                    self.selectedIndex2 = nil
                                } else {
                                    self.selectedIndex2 = index
                                }
                            }) {
                                Text(SharingType[index])
                                    .frame(width: .infinity, height: 12)
                                    .font(.system(size: 11.5))
                                    .foregroundColor(self.selectedIndex2 == index ? .white : .black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 8)
                                    .background(self.selectedIndex2 == index ? Color(UIColor(hex: "#7F32CD")) : Color.white)
                                    .cornerRadius(15)
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                            }}
                        Spacer()
                    }.padding(.leading)
                    
                    Rectangle()
                        .foregroundStyle(Color(uiColor: .systemGray5))
                        .padding([.leading, .trailing]).frame(height: 2) .padding(.top, 5)
                    
                    // No. of Beds
                    HStack { Text("No. of Beds").bold() .font(.system(size: 14))
                        Spacer()
                    }.padding(.leading).padding(.top, 5)
                    HStack {
                        PlusMinusBTN()
                        Spacer()
                    }.padding(.leading).padding(.top, 5)
                    
                    Rectangle()
                        .foregroundStyle(Color(uiColor: .systemGray5))
                        .padding([.leading, .trailing]).frame(height: 2) .padding(.top, 5)
                    
                    // PG Amenities
                    HStack { Text("PG Amenities").bold() .font(.system(size: 14))
                        Spacer()
                    }.padding(.leading).padding(.top, 5)
                    
                    GridButtons(tags: ["WiFi", "TV", "Parking", "Washing Machine", "Lift", "Hot Water", "Lounge", "Gym"])
                        .padding(.leading)
                    
                    Rectangle()
                        .foregroundStyle(Color(uiColor: .systemGray5))
                        .padding([.leading, .trailing]).frame(height: 2) .padding(.top, 5)
                    
                    // Food Options
                    HStack { Text("Food Options").bold() .font(.system(size: 14))
                        Spacer()
                    }.padding(.leading).padding(.top, 5)
                    
                    GridButtons(tags: ["Veg", "Non Veg"])
                        .padding(.leading)
                    
                    Rectangle()
                        .foregroundStyle(Color(uiColor: .systemGray5))
                        .padding([.leading, .trailing]).frame(height: 2) .padding(.top, 5)
                    
                    // Room Amenities
                    HStack { Text("Room Amenities").bold() .font(.system(size: 14))
                        Spacer()
                    }.padding(.leading).padding(.top, 5)
                    
                    GridButtons(tags: ["AC", "Table","Chair", "Matress","Bed", "Pillow","Shoe Racks","Balcony","Mirror"])
                        .padding(.leading)
                    
                    Rectangle()
                        .foregroundStyle(Color(uiColor: .systemGray5))
                        .padding([.leading, .trailing]).frame(height: 2) .padding(.top, 5)
                    
                    // Building Type
                    HStack { Text("Building Type").bold() .font(.system(size: 14))
                        Spacer()
                    }.padding(.leading).padding(.top, 5)
                    
                    GridButtons(tags: ["Studio Rooms", "Hotel Rooms","Apartments"])
                        .padding(.leading)
                        .padding(.bottom, 10)
                }
            }
            
            //3rd Part
            HStack(spacing: 10) {
                Spacer()
                Button(action: {
                    //print("ScheduleButton tapped!")
                    dismiss()
                }) {
                    Text("Clear")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .padding(10)
                        .background(Color(uiColor: .systemGray4))
                        .foregroundColor(.black)
                        .cornerRadius(5)
                }.frame(height: 30)
                Button(action: {
                    //print("Book Button tapped!")
                    dismiss()
                }) {
                    Text("Apply")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .padding(10)
                        .background(Color(UIColor(hex: "#F25621")))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }.frame(height: 30)
                
            }.padding(.trailing).padding(.bottom, 5).padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(30)
        .transition(.move(edge: .bottom))
        
        .background(Color.white)

    }
    
}
