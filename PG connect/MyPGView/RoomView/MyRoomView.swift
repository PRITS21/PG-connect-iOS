//
//  MyRoomView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 23/03/24.
//

import SwiftUI

struct MyRoomView: View {
    @Environment(\.dismiss) var dismiss
    @State private var WifiAlert = false
    @State private var HostAleart = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
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
                    RoomID()
                }.padding(.top, 5).padding(.bottom, 10)
                
                
                // Room Members
                HStack {
                    Text("Room Members")
                        .fontWeight(.medium).foregroundStyle(Color.black).font(.system(size: 14)).padding(.leading, 20)
                    Spacer()
                    HStack(spacing: 5) {
                        Text("Group Chat").fontWeight(.medium).foregroundStyle(Color.blue).font(.system(size: 14))
                        Image(systemName: "text.bubble.fill").foregroundColor(.blue).imageScale(.medium).padding(.trailing, 20)
                    }
                }.padding(.top)
                
                
                ForEach(0..<1) { index in
                    Rectangle()
                        .frame(width: .infinity, height: 70)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                        .overlay (
                            HStack(spacing: 15) {
                                Image(systemName: "person.circle.fill").resizable().frame(width: 42, height: 42)
                                Text("Test user").fontWeight(.semibold).foregroundStyle(Color.black).font(.system(size: 14))
                                Spacer()
                                Image(systemName: "phone.fill").foregroundColor(.black).imageScale(.medium)
                                Image(systemName: "text.bubble.fill")
                                    .foregroundColor(.black).imageScale(.medium).padding(.trailing, 10)
                                
                            }.padding(.leading, 20)
                        )
                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
                
                HStack(spacing: 3) {
                    Button {
                        WifiAlert = true
                    } label: {
                        Text("Wifi").fontWeight(.semibold).foregroundStyle(Color.blue).font(.system(size: 14))
                        Image(systemName: "arrow.right").foregroundStyle(Color.blue)
                    }
                    .popover(isPresented: $WifiAlert) {
                        
                        VStack(spacing: 15){
                            Text("WiFi Name: Wifi").fontWeight(.semibold).font(.system(size: 15))
                            Text("Password: 123").fontWeight(.semibold).font(.system(size: 15))
                        }
                        .frame(minWidth: 200, minHeight: 120)
                        .presentationCompactAdaptation(.none)
                    }
                    
                    Spacer()
                }.padding(.top, 20).padding(.leading, 20)
                
                // Owner or Warden
                HStack {
                    Text("Owner or Warden").fontWeight(.medium).foregroundStyle(Color.black).font(.system(size: 14)).padding(.leading, 20)
                    Spacer()
                    HStack(spacing: 5) {
                        Text("Group Chat").fontWeight(.medium).foregroundStyle(Color.blue).font(.system(size: 14))
                        Image(systemName: "phone.fill").foregroundColor(.blue).imageScale(.medium).padding(.trailing, 30)
                    }
                }.padding(.top)
                
                
                Owner_Warden()
                
                HStack(spacing: 3) {
                    
                    Button {
                        HostAleart = true
                    } label: {
                        Text("Host a Friend").fontWeight(.semibold).foregroundStyle(Color.blue).font(.system(size: 14))
                        Image(systemName: "arrow.right").foregroundStyle(Color.blue)
                    }
                    .popover(isPresented: $HostAleart,
                             attachmentAnchor: .point(.topTrailing),
                             arrowEdge: .top,
                             content: {
                        
                        HostAFriend()
                            .padding([.top, .bottom], 10)
                            .frame(minWidth: 300)
                            .presentationCompactAdaptation(.popover)
                    })
                    
                    Spacer()
                }.padding(.top, 20).padding(.leading, 20)
                
                // Guest
                HStack {
                    Text("Guest").fontWeight(.medium).foregroundStyle(Color.black).font(.system(size: 14)).padding(.leading, 20)
                    Spacer()
                }.padding(.top)
                
                ForEach(0..<1) { index in
                    Rectangle()
                        .frame(width: .infinity, height: 70)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                        .overlay (
                            HStack(spacing: 15) {
                                
                                VStack(alignment: .listRowSeparatorLeading,spacing: 7) {
                                    Text("Lexi").fontWeight(.semibold).foregroundStyle(Color.black).font(.system(size: 14))
                                    Text("ENTRY 10:20PM  EXIT 11:20 AM")
                                        .foregroundStyle(Color.black).font(.system(size: 12))
                                }
                                Spacer()
                                Image(systemName: "phone.fill").foregroundColor(.black).imageScale(.medium)
                                Image(systemName: "text.bubble.fill")
                                    .foregroundColor(.black).imageScale(.medium).padding(.trailing, 10)
                                
                            }.padding(.leading, 20)
                        )
                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
                
                Spacer()
            }
        }.navigationBarBackButtonHidden()
    }
    
    func Owner_Warden() -> some View {
        VStack {
            Rectangle()
                .frame(width: .infinity, height: 70)
                .foregroundColor(.white)
                .cornerRadius(10)
            
                .overlay (
                    HStack(spacing: 15) {
                        Image(systemName: "person.circle.fill").resizable().frame(width: 42, height: 42)
                        VStack(alignment: .listRowSeparatorLeading,spacing: 7) {
                            Text("Roger").fontWeight(.semibold).foregroundColor(.black).font(.system(size: 14))
                            Text("owner").fontWeight(.semibold).foregroundStyle(Color.orange).font(.system(size: 14))
                        }
                        Spacer()
                        Image(systemName: "phone.fill").foregroundColor(.black).imageScale(.medium)
                        Image(systemName: "text.bubble.fill").foregroundColor(.black).imageScale(.medium).padding(.trailing, 10)
                        
                    }.padding(.leading, 20)
                )
                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                .padding(.horizontal)
                .padding(.top, 10)
            
            Rectangle()
                .frame(width: .infinity, height: 70)
                .foregroundColor(.white)
                .cornerRadius(10)
            
                .overlay (
                    HStack(spacing: 15) {
                        Image(systemName: "person.circle.fill").resizable().frame(width: 42, height: 42)
                        VStack(alignment: .listRowSeparatorLeading,spacing: 7) {
                            Text("Alex").fontWeight(.semibold).foregroundColor(.black).font(.system(size: 14))
                            Text("Warden").fontWeight(.semibold).foregroundStyle(Color.orange).font(.system(size: 14))
                        }
                        Spacer()
                        Image(systemName: "phone.fill").foregroundColor(.black).imageScale(.medium)
                        Image(systemName: "text.bubble.fill").foregroundColor(.black).imageScale(.medium).padding(.trailing, 10)
                        
                    }.padding(.leading, 20)
                )
                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                .padding(.horizontal)
                .padding(.top, 10)
        }
    }
    
    func RoomID() -> some View {
        VStack {
            Text("My Room").multilineTextAlignment(.center).font(.system(size: 20)).bold()
                .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
            
            HStack {
                Text("Room no:").bold().foregroundStyle(Color.black).font(.system(size: 12.5))
                Text("101").foregroundStyle(Color.black).font(.system(size: 12.5))
                Text("Bed no:").bold().foregroundStyle(Color.black).font(.system(size: 12.5))
                Text("101A").foregroundStyle(Color.black).font(.system(size: 12.5))
            }}}
}


struct MyRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MyRoomView()
    }
}
