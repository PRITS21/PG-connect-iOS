//
//  myPGView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 04/03/24.
//

import SwiftUI

struct myPGView: View {
    @State private var roomDetails: RoomDetailsResponse?
    @ObservedObject var viewModel = AuthService.shared
    @Environment(\.dismiss) var dismiss
    
    @State private var previousOffset: CGFloat = .zero
        @State private var currentOffset: CGFloat = .zero
    
    var body: some View {
        NavigationView {
            VStack {
                
                // 1st part - Header
                ZStack(alignment: .center) {
                    if let roomDetails = viewModel.room {
                        
                        Text("\(roomDetails.room.pgid.pgname)")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                    }
                }.padding(.top, 5).padding(.bottom, 30)
                
                //Menu button
                NavigationLink(destination: TodayMenuView()){
                    Image(uiImage: UIImage(named: "TodayMenu_image")!)
                        .resizable()
                }
                .frame(width: .infinity,height: 100)
                .padding(.horizontal)
                
                //Room Button
                NavigationLink(destination: MyRoomView()){
                    Image(uiImage: UIImage(named: "Room_image")!)
                        .resizable()
                }
                .frame(width: .infinity,height: 100)
                .padding(.horizontal)
                
                //DND Button
                NavigationLink(destination: DNDView()){
                    Image(uiImage: UIImage(named: "DND_image")!)
                        .resizable()
                }
                .frame(width: .infinity,height: 100)
                .padding(.horizontal)
                
                //Notice Button
                NavigationLink(destination: Noticeview()){
                    Image(uiImage: UIImage(named: "Notice_image")!)
                        .resizable()
                }
                .frame(width: .infinity,height: 100)
                .padding(.horizontal)
                
                Spacer()
                
            }
            
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getUserRoomDetails()
            
        }
    }
}

#Preview {
    myPGView()
}
