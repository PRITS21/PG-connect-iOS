//
//  DNDView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 23/03/24.
//

import SwiftUI

struct DNDView: View {
    @Environment(\.dismiss) var dismiss
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        NavigationView {
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
                    Text("Do Not Disturb Mode")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 19))
                        .bold()
                        .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                    
                }.padding(.top, 5).padding(.bottom, 10)
                
                //Dates
                HStack(spacing: 10) {
                    
                    VStack {
                        HStack {
                            Text("Entry Date").bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 12))
                            Spacer()
                        }
                        HStack{
                            Text(startDate.formatted(.dateTime.day().month().year()))
                                .font(.system(size: 13, weight: .semibold))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 9, weight: .bold)).padding(.trailing)
                            Spacer()
                        }
                        .frame(width: .infinity, height: 20)
                        .contentShape(Rectangle())
                        .padding(8)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                        .overlay {
                            HStack {
                                DatePicker(selection: $startDate, displayedComponents: .date) {}
                                    .labelsHidden().opacity(0.011)
                            }
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("Exit Date").bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 12))
                            Spacer()
                        }
                        HStack{
                            Text(endDate.formatted(.dateTime.day().month().year()))
                                .font(.system(size: 13, weight: .semibold))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 9, weight: .bold))
                            Spacer()
                        }
                        .frame(width: .infinity, height: 20)
                        .contentShape(Rectangle())
                        .padding(8)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                        .overlay {
                            DatePicker(selection: $endDate, displayedComponents: .date) {}
                                .labelsHidden().opacity(0.011)
                        }
                    }
                }.padding(.top).padding(.horizontal, 40)
                
                //Drop down menu
                HStack{
                    Text("Select Coming Session").bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 12))
                    Spacer()
                }.padding(.leading, 45).padding(.top, 10)
                VStack(alignment: .listRowSeparatorLeading) {
                    
                    DropdownMenu(options: ["Tiffin", "Lunch", "Dinner"])
                        .padding(.top, 5)
                }.padding(.horizontal, 25)
                
                Button {
                    
                } label: {
                    Text("Start DND")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: 10)
                        .foregroundColor(.white)
                        .padding()
                        .background( Rectangle()
                            .fill(Color(UIColor(hex: "#7F32CD")))
                            .cornerRadius(10)
                        )
                }.padding(.horizontal, 40).padding(.top, 30)
                
                Rectangle()
                    .foregroundStyle(Color(uiColor: .systemGray4))
                    .frame(height: 2)
                    .padding(.top, 20)
                
                HStack {
                    Text("Active DND")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16))
                        .bold()
                        .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                    Spacer()
                }.padding(.leading, 40).padding(.top,10)
                
                ForEach(0..<1) { index in
                    Rectangle()
                        .frame(width: .infinity, height: 80)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                        .overlay (
                            HStack{
                                
                                VStack(alignment: .listRowSeparatorLeading, spacing: 4) {
                                    HStack(spacing: 1) {
                                        Text("Start Date: ")
                                            .fontWeight(.semibold).foregroundStyle(Color.black).font(.system(size: 12.5))
                                        Text(" 23/03/2024").foregroundStyle(Color.gray).font(.system(size: 12.5))
                                    }
                                    HStack(spacing: 1) {
                                        Text("End Date: ")
                                            .fontWeight(.semibold).foregroundStyle(Color.black).font(.system(size: 12.5))
                                        Text(" 23/03/2024").foregroundStyle(Color.gray).font(.system(size: 12.5))
                                    }
                                    HStack(spacing: 5) {
                                        Text("Session:")
                                            .fontWeight(.semibold).foregroundStyle(Color.black).font(.system(size: 12.5))
                                        Text("Lunch").foregroundStyle(Color.gray).font(.system(size: 12.5))
                                    }
                                }
                                
                                Spacer()
                                Image(uiImage: UIImage(named: "Pencil_icon")!)
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(Color.black).bold()
                                    .padding(.trailing, 30)
                                
                            }.padding(.leading, 20)
                        )
                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                        .padding(.horizontal, 25)
                        .padding(.top, 10)
                }
                
                Spacer()
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    DNDView()
}
