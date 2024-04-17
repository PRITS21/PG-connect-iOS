//
//  NotificationView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 13/04/24.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = AuthService.shared
    
    var body: some View {
        VStack{
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.black)
                        .imageScale(.large)
                        .fontWeight(.semibold)
                }
                
                Text("Notifications")
                    .bold()
                    .foregroundStyle(Color.black)
                    .font(.system(size: 18))
                    .padding(.leading, 30)
                Spacer()
            }.padding(.leading)
            
            ScrollView {
                if let notificationResponse = viewModel.notificationResponse {
                    ForEach(notificationResponse.notifications) { notification in
                        NotificationItemView(notification: notification)
                            .padding(.horizontal)
                            .padding(.top, 10)
                    }
                } else {
                    Text("Loading...")
                        .padding()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getNotifications()
        }
    }
}

struct NotificationItemView: View {
    let notification: Notification
    
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, minHeight: 80)
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
            .overlay (
                HStack {
                    VStack(alignment: .leading, spacing: 5){
                        Text(notification.title)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                            .font(.system(size: 15))
                        
                        Text(notification.message)
                            .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                            .font(.system(size: 12)).fontWeight(.medium)
                        
                        Spacer()
                    }.padding(.leading, 30).padding(.top, 15)
                    Spacer()
                    
                    VStack {
                        Text(notification.date.formattedDate3())
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                            .font(.system(size: 15))
                        Spacer()
                    }.padding(.trailing).padding(.top, 15)
                }
            )
            .background(Color.white)
    }
    
    
}
