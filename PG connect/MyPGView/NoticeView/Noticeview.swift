//
//  Noticeview.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 23/03/24.
//

import SwiftUI

struct Noticeview: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var NoticeAlert = false
    
    
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
                    Text("Notice Period")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 19))
                        .bold()
                        .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                    
                }.padding(.top, 5).padding(.bottom, 10)
                
                
                
                HStack {
                    VStack{
                        HStack {
                            Text("Vacant Time")
                                .bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 14))
                                .padding(.bottom, 5)
                            Spacer()
                        }
                        HStack{
                            Text(selectedDate.formatted(.dateTime.day().month().year()))
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
                            HStack {
                                ForEach(0..<3) {_ in
                                    DatePicker(selection: $selectedDate, displayedComponents: .date) {}
                                        .background(Color.green).labelsHidden()
                                        .opacity(0.011)
                                }
                            }
                        }.padding(.bottom, 20).padding(.trailing)
                        
                        HStack {
                            Text("Approx. Time")
                                .bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 14))
                                .padding(.bottom, 5)
                            Spacer()
                        }
                        HStack{
                            Text(selectedTime.formatted(.dateTime.hour().minute()))
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
                            HStack {
                                ForEach(0..<3) {_ in
                                    DatePicker(selection: $selectedTime, displayedComponents: .hourAndMinute) {}
                                        .background(Color.green).labelsHidden()
                                        .opacity(0.011)
                                }
                            }             // <<< here
                        }.padding(.bottom, 10).padding(.trailing)
                    }.padding(.top, 20)
                    Spacer()
                }.padding(.leading, 40)
                
                Button {
                    
                } label: {
                    Text("Serve Notice Period")
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
                
                // List
                ForEach(0..<1) { index in
                    Rectangle()
                        .frame(width: .infinity, height: 80)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                        .overlay (
                            HStack{
                                
                                VStack(alignment: .listRowSeparatorLeading, spacing: 4) {
                                    HStack(spacing: 1) {
                                        Text("Vacant Date: ")
                                            .fontWeight(.semibold).foregroundStyle(Color.black).font(.system(size: 12.5))
                                        Text(" 23/03/2024").foregroundStyle(Color.gray).font(.system(size: 12.5)).padding(.trailing, 7)
                                        
                                        Text("Status:")
                                            .fontWeight(.semibold).foregroundStyle(Color.black).font(.system(size: 12.5))
                                        Text("Done").foregroundStyle(Color.gray).font(.system(size: 12.5))
                                        
                                        Spacer()
                                        Button {
                                            NoticeAlert = true
                                        } label: {
                                            Image(systemName: "ellipsis").tint(Color(UIColor(hex: "#F25621"))).bold()
                                                .padding(.trailing, 10)
                                        }
                                        .popover(isPresented: $NoticeAlert,
                                                 attachmentAnchor: .point(.topLeading),
                                                 arrowEdge: .bottom,
                                                 content: {
                                            VStack(spacing: 15){
                                                Text("Change Notice period Date")
                                                    .fontWeight(.semibold).font(.system(size: 12.5))
                                                Divider()
                                                Text("Notice Period Cancel").fontWeight(.semibold).font(.system(size: 12.5))
                                            }
                                            .frame(minWidth: 200, minHeight: 120)
                                            .presentationCompactAdaptation(.none)
                                        })
                                        
                                    }
                                    HStack(spacing: 1) {
                                        Text("Days: ")
                                            .fontWeight(.semibold).foregroundStyle(Color.black).font(.system(size: 12.5))
                                        Text("3").foregroundStyle(Color.gray).font(.system(size: 12.5))
                                    }
                                    
                                }
                                
                                Spacer()
                                
                            }.padding(.leading, 20)
                        )
                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                }
                
                Spacer()
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    Noticeview()
}
