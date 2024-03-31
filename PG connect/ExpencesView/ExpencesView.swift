//
//  ExpencesView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 04/03/24.
//

import SwiftUI

struct ExpencesView: View {
    @Environment(\.dismiss) var dismiss
    @State var activeSheet: ActiveSheet?
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    //@State private var NoticeAlert = false
    //@State private var isAddGroupPresented = false
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // 1st part - Header
                HStack{
                    Button { dismiss() } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black).imageScale(.large).bold().padding(.leading, 15)
                            Spacer()
                        }
                    }
                    Text("Expenses")
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
                    }
                    .padding(.trailing, 10)
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
                .padding(.bottom, 5).padding(.horizontal).padding(.top, 10)
                
                HStack (spacing: 15) {
                    Button {
                        activeSheet = .first
                    } label: {
                        Circle()
                            .frame(width: 35, height: 35).foregroundColor(.gray.opacity(0.2))
                            .overlay {
                                Image(systemName: "plus").foregroundColor(.black).bold().imageScale(.small)
                            }
                        Text("Add Group").font(.system(size: 18)).fontWeight(.medium).foregroundColor(.black)
                    }
                    Spacer()
                    
                }.padding(.leading).padding(.top, 10)
                
                ExpensesBars()
                    
                Spacer()
                
                HStack {
                    Spacer()
                    Button{
                        activeSheet = .second
                    }label: {
                        Image(uiImage: UIImage(named: "AddExpenses_image")!)
                            .resizable().frame(width: 140, height: 37)
                    }.padding(.trailing).padding(.bottom, 30)
                }
            }
            .sheet(item: $activeSheet) { item in
                switch item {
                case .first:
                    AddGroupSheet()
                        .presentationCornerRadius(21)
                        .presentationDetents([.height(250)])
                case .second:
                    AddExpensesSheet()
                        .presentationCornerRadius(21)
                        .presentationDetents([.medium, .large])
                }
                
            }
        }.navigationBarBackButtonHidden()
    }
}


struct ExpensesBars: View {
    @State private var Group_Name: String = "Daily march expenses"
    @State private var Price = "$2000"
    
    var body: some View {
        
        
        VStack {
            ForEach(0..<3) { _ in
                
                NavigationLink(destination: CardsView()) {
                    Rectangle()
                        .frame(width: .infinity, height: 80)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                        .overlay (
                            HStack {
                                Image(uiImage: UIImage(named: "Expenses_image")!)
                                    .resizable()
                                    .frame(width: 101, height: 75)
                                
                                VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                                    
                                    Text(Group_Name)
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.black)
                                        .font(.system(size: 16))
                                    Text("Total: \(Price)")
                                        .foregroundStyle(Color.black)
                                        .font(.system(size: 12)).fontWeight(.medium)
                                    
                                    Spacer()
                                }.padding(.leading, 20).padding(.top, 22)
                                Spacer()
                            }
                        )
                        .background(Color.white)
                        .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
        }.padding(.top, 10)
    }
}

#Preview {
    ExpencesView()
}
