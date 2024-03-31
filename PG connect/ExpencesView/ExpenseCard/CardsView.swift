//
//  CardsView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 24/03/24.
//

import SwiftUI

struct CardsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var NoticeAlert = false
    @State private var isAddGroupPresented = false
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                //MARK: 1st part - Header
                HStack{
                    Button { dismiss() } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black).imageScale(.large).bold().padding(.leading, 15)
                            Spacer()
                        }
                    }
                    Text("Daily march")
                        .multilineTextAlignment(.center).font(.system(size: 19)).bold()
                        .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                    
                    Button { dismiss() } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "ellipsis")
                                .foregroundColor(.black).imageScale(.large).bold().padding(.trailing, 15)
                        }
                    }
                }.padding(.top, 5).padding(.bottom, 10)
                
                //MARK: Search Bar
                HStack {
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 40)
                            .cornerRadius(10)
                            .foregroundColor(Color.white)
                        
                        HStack {
                            TextField("Search Expenses", text: $searchText)
                                .font(.system(size: 15))
                                .padding(.leading, 15)
                                .frame(height: 40)
                                .foregroundColor(.black)
                                .background(Color.clear)
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Image(uiImage: UIImage(named: "search_icon_orange")!)
                                .foregroundColor(.orange).padding(.trailing)
                        }
                    }.padding(.trailing, 10)
                    Spacer()
                    Rectangle()
                        .frame(width: 40,height: 40).cornerRadius(10)
                        .foregroundStyle(Color.white)
                        .overlay(
                            Image(uiImage: UIImage(named: "Date_icon")!).resizable().frame(width: 18, height: 18)
                        ).padding(.trailing, 5)
                    Rectangle()
                        .frame(width: 40,height: 40).cornerRadius(10)
                        .foregroundStyle(Color.white)
                        .overlay(
                            Image(uiImage: UIImage(named: "filter_icon")!).resizable().frame(width: 18, height: 18)
                        )
                    
                }
                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                .padding(.bottom, 20).padding(.horizontal).padding(.top, 10)
                
                HStack {
                    Text("List Of This Group").multilineTextAlignment(.center).font(.system(size: 19)).fontWeight(.medium)
                    Spacer()
                }.padding(.leading)
                
                ScrollView {
                    VStack (spacing: 3){
                        
                        ForEach(0..<3) { _ in
                            Rectangle()
                                .frame(width: .infinity, height: 75)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                                .overlay (
                                    HStack {
                                        
                                        //1st
                                        VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                                            Text("Mar").fontWeight(.medium).foregroundStyle(Color(UIColor(hex: "#F25621")))
                                                .font(.system(size: 17))
                                            Text("20").foregroundStyle(Color.black).font(.system(size: 17)).fontWeight(.medium)
                                            Spacer()
                                        }.padding(.leading, 20).padding(.top, 12)
                                        
                                        //2nd
                                        VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                                            
                                            Text("Rice bag")
                                                .fontWeight(.medium).foregroundStyle(Color.black).font(.system(size: 17))
                                            Text("Paid: 1250")
                                                .foregroundStyle(Color.black).font(.system(size: 14))
                                            Spacer()
                                        }.padding(.leading, 30).padding(.top, 12)
                                        Spacer()
                                        
                                        //3rd
                                        VStack {
                                            Text("KG: 25")
                                                .fontWeight(.medium)
                                                .foregroundStyle(Color.black)
                                                .font(.system(size: 16))
                                            Spacer()
                                        }.padding(.top, 12).padding(.trailing)
                                    }
                                )
                                .background(Color.white)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                    }
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    CardsView()
}
