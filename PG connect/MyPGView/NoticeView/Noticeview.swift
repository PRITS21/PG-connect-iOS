//
//  Noticeview.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 23/03/24.
//

import SwiftUI

struct NoticePeriod: Codable, Hashable {
    let _id: String
    let vacatedate: String
    let status: String
    let editaccess: Bool
    let days: Int
}

struct Noticeview: View {
    @ObservedObject var viewModel = AuthService.shared
    @Environment(\.dismiss) var dismiss
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var showAlert = false
    @State private var errorMessage: String?
    
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
                    showAlert = true
                    viewModel.postNoticePeriod()
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
                
                if let noticePeriod = viewModel.noticePeriodData?.noticeperiod {
                    NoticeListView(noticePeriods: noticePeriod)
                } else {
                    Text("Loading...")
                        .padding()
                        .onAppear {
                            viewModel.getNoticePeriod()
                        }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getNoticePeriod()
        }
        .alert(isPresented: $showAlert) {
                    if let responseString = viewModel.noticePeriodResponse {
                        return Alert(title: Text("Response"), message: Text(responseString), dismissButton: .default(Text("OK")))
                    } else {
                        return Alert(title: Text("Error"), message: Text("Failed to get response"), dismissButton: .default(Text("OK")))
                    }
                }
    }
}
struct NoticeListView: View {
    @State private var noticeAlert = false
    @ObservedObject var viewModel = AuthService.shared
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
    
    var noticePeriods: NoticePeriod // Array of NoticePeriod objects
    
    var body: some View {
        Rectangle()
            .frame(width: .infinity, height: 80)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
            .overlay (
                HStack{
                    VStack(alignment: .listRowSeparatorLeading, spacing: 4) {
                        HStack(spacing: 1) {
                            Text("Vacant Date: ")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 12.5))
                            Text(formatDate(noticePeriods.vacatedate))
                                .foregroundStyle(Color.gray)
                                .font(.system(size: 12.5))
                                .padding(.trailing, 7)
                            
                            Text("Status: ")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 12.5))
                            Text(noticePeriods.status)
                                .foregroundStyle(Color.gray)
                                .font(.system(size: 12.5))
                            
                            Spacer()
                            Button {
                                noticeAlert = true
                            } label: {
                                Image(systemName: "ellipsis")
                                    .tint(Color(UIColor(hex: "#F25621")))
                                    .bold()
                                    .padding(.trailing, 10)
                            }
                            .popover(isPresented: $noticeAlert,
                                     attachmentAnchor: .point(.topLeading),
                                     arrowEdge: .bottom,
                                     content: {
                                VStack(spacing: 15){
                                    Text("Change Notice period Date")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12.5))
                                    Divider()
                                    Text("Request Notice Cancel")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 12.5))
                                }
                                .frame(minWidth: 200, minHeight: 120)
                                .presentationCompactAdaptation(.none)
                            })
                            
                        }
                        HStack(spacing: 1) {
                            Text("Days: ")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 12.5))
                            Text("\(noticePeriods.days)")
                                .foregroundStyle(Color.gray)
                                .font(.system(size: 12.5))
                        }
                        
                    }
                    
                    Spacer()
                    
                }.padding(.leading, 20)
            )
            .padding(.horizontal, 25)
            .padding(.top, 20)
        
    }
    
    func formatDate(_ dateString: String) -> String {
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd-MM-yyyy"
            return outputFormatter.string(from: date)
        }
        return "Invalid Date"
    }
}

struct NoticePeriodData: Codable {
    let noticeperiod: NoticePeriod
}

