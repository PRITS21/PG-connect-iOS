//
//  TodayMenuView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 23/03/24.
//

import SwiftUI

struct TodayMenuView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTab: Tab = .Tiffin
    @State private var FoodName_tiffin: String = "Dhal"
    @State private var FoodName_lunch: String = "Biriyani"
    @State private var FoodName_dinner: String = "Rice"
    @State private var SkipSheetPresented = false
    
    enum Tab {
        case Tiffin, Lunch, Dinner
    }
    
    var body: some View {
        NavigationView {
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
                    Text("Today Menu")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    Spacer()
                    
                    Image(systemName: "doc.viewfinder")
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .bold().padding(.trailing)
                    
                }.padding(.leading)
                
                HStack {
                    
                    Button(action: {
                        selectedTab = .Tiffin
                    }) {
                        Text("Tiffin")
                            .fontWeight(.medium)
                            .foregroundColor(selectedTab == .Tiffin ? Color(UIColor(hex: "#7F32CD")): Color(UIColor(hex: "#5E6278")))
                            .font(.system(size: 16))
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    Button(action: {
                        selectedTab = .Lunch
                    }) {
                        Text("Lunch")
                            .fontWeight(.medium)
                            .foregroundColor(selectedTab == .Lunch ? Color(UIColor(hex: "#7F32CD")) : Color(UIColor(hex: "#5E6278")))
                            .font(.system(size: 16))
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        selectedTab = .Dinner
                    }) {
                        Text("Dinner")
                            .fontWeight(.medium)
                            .foregroundColor(selectedTab == .Dinner ? Color(UIColor(hex: "#7F32CD")) : Color(UIColor(hex: "#5E6278")))
                            .font(.system(size: 16))
                        
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
                                .frame(width: proxy.size.width / 3, height: 2) // Adjust width dynamically
                                .offset(x: selectedTab == .Tiffin ? 0 : selectedTab == .Lunch ? proxy.size.width / 3 : proxy.size.width * 2 / 3)
                                .animation(.easeInOut)
                        }
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomLeading)
                    }
                )
                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                .padding(.top)
                
                
                if selectedTab == .Tiffin
                {
                    TiffinView(Food_tiffin: $FoodName_tiffin)
                    
                } else if selectedTab == .Lunch {
                    
                    LunchView(Food_lunch: $FoodName_lunch)
                } else {
                    DinnerView(Food_dinner: $FoodName_dinner)
                }
                
                Button{
                    SkipSheetPresented = true
                } label: {
                    Image(uiImage: UIImage(named: "SkipMenu")!)
                    Spacer()
                }.padding(.leading).padding(.top, 40)
                
                
                Spacer()
            }
            .sheet(isPresented: $SkipSheetPresented){
                SkipSheet()
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(21)
            }
        }.navigationBarBackButtonHidden()
    }
}


struct TiffinView: View {
    @Binding var Food_tiffin: String
    
    var body: some View {
        
        
        VStack {
            ForEach(0..<3) { _ in
                Rectangle()
                    .frame(width: .infinity, height: 80)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.top, 7)
                    .overlay (
                        HStack {
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                    .foregroundColor(Color(uiColor: .systemGray6))
                                
                                Image(uiImage: UIImage(named: "Food")!)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                
                            }.padding(.leading, 30)
                            VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                                
                                Text(Food_tiffin)
                                    .bold()
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 16))
                                Text("08:30PM to 10:30PM")
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 12)).fontWeight(.medium)
                                
                                Spacer()
                            }.padding(.leading, 30).padding(.top, 22)
                            Spacer()
                        }
                    )
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    .background(Color.white)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
        }.padding(.top, 30)
    }
}

struct LunchView: View {
    @Binding var Food_lunch: String
    
    var body: some View {
        
        
        VStack {
            ForEach(0..<3) { _ in
                Rectangle()
                    .frame(width: .infinity, height: 80)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.top, 7)
                    .overlay (
                        HStack {
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                    .foregroundColor(Color(uiColor: .systemGray6))
                                
                                Image(uiImage: UIImage(named: "Food")!)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                
                            }.padding(.leading, 30)
                            VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                                
                                Text(Food_lunch)
                                    .bold()
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 16))
                                Text("08:30PM to 10:30PM")
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 12)).fontWeight(.medium)
                                
                                Spacer()
                            }.padding(.leading, 30).padding(.top, 22)
                            Spacer()
                        }
                    )
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    .background(Color.white)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
        }.padding(.top, 30)
    }
}


struct DinnerView: View {
    @Binding var Food_dinner: String
    
    var body: some View {
        
        
        VStack {
            ForEach(0..<3) { _ in
                Rectangle()
                    .frame(width: .infinity, height: 80)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.top, 7)
                    .overlay (
                        HStack {
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                    .foregroundColor(Color(uiColor: .systemGray6))
                                
                                Image(uiImage: UIImage(named: "Food")!)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                
                            }.padding(.leading, 30)
                            VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                                
                                Text(Food_dinner)
                                    .bold()
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 16))
                                Text("08:30PM to 10:30PM")
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 12)).fontWeight(.medium)
                                
                                Spacer()
                            }.padding(.leading, 30).padding(.top, 22)
                            Spacer()
                        }
                    )
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    .background(Color.white)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
        }.padding(.top, 30)
    }
}
#Preview {
    TodayMenuView()
}
