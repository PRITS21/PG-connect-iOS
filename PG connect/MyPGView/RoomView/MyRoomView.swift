//
//  MyRoomView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 23/03/24.
//

import SwiftUI

struct MyRoomView: View {
    @State private var roomDetails: RoomDetailsResponse?
    @ObservedObject var viewModel = AuthService.shared
    @Environment(\.dismiss) var dismiss
    @State private var WifiAlert = false
    @State private var HostAleart = false
    
    
    var body: some View {
        NavigationView {
            if let roomDetails = viewModel.room {
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
                    
                    
                    ForEach(roomDetails.room.users, id: \.self) { userDetail in
                        Rectangle()
                            .frame(width: .infinity, height: 70)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                            .overlay (
                                HStack(spacing: 15) {
                                    
                                    if let imageUrl = URL(string: userDetail.user.profileimage) {
                                        AsyncImage(url: imageUrl) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 42, height: 42)
                                                .clipShape(Circle())
                                        } placeholder: {
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .frame(width: 42, height: 42)
                                        }
                                    }
                                    Text(userDetail.user.name)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.black)
                                        .font(.system(size: 14))
                                    Spacer()
                                    Button{
                                        if let url = URL(string: "tel://\(userDetail.user.phone)"), UIApplication.shared.canOpenURL(url) {
                                            UIApplication.shared.open(url)
                                        }
                                    } label: {
                                        Image(systemName: "phone.fill")
                                            .foregroundColor(.black)
                                            .imageScale(.medium)
                                    }
                                    Image(systemName: "text.bubble.fill")
                                        .foregroundColor(.black)
                                        .imageScale(.medium)
                                        .padding(.trailing, 10)
                                }
                                    .padding(.leading, 20)
                            )
                        
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
                                
                                Text("Wi-Fi Name: \(roomDetails.room.wifiusername)").fontWeight(.semibold).font(.system(size: 15))
                                Text("Password: \(roomDetails.room.wifipassword)").fontWeight(.semibold).font(.system(size: 15))
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
                            Text("Call Gate").fontWeight(.medium).foregroundStyle(Color.blue).font(.system(size: 14))
                            Image(systemName: "phone.fill").foregroundColor(.blue).imageScale(.medium).padding(.trailing, 5)
                                .onTapGesture {
                                    if let url = URL(string: "tel://\(roomDetails.room.pgid.gate1)"), UIApplication.shared.canOpenURL(url) {
                                        UIApplication.shared.open(url)
                                    }}
                            Image(systemName: "phone.fill").foregroundColor(.blue).imageScale(.medium).padding(.trailing, 30)
                                .onTapGesture {
                                    if let url = URL(string: "tel://\(roomDetails.room.pgid.gate2)"), UIApplication.shared.canOpenURL(url) {
                                        UIApplication.shared.open(url)
                                    }}
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
                        .sheet(isPresented: $HostAleart) {
                            HostAFriend()
                                .presentationDetents([.height(450)])
                        }
                        
                        Spacer()
                    }.padding(.top, 20).padding(.leading, 20)
                    
                    //MARK: Guest
                    HStack {
                        Text("Guest").fontWeight(.medium).foregroundStyle(Color.black).font(.system(size: 14)).padding(.leading, 20)
                        Spacer()
                    }.padding(.top)
                    
                    ScrollView {
                    ForEach(roomDetails.guests, id: \.self) { guest in
                        
                        Rectangle()
                            .frame(width: .infinity, height: 80)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                            .overlay (
                                HStack(spacing: 15) {
                                    VStack(alignment: .leading, spacing: 1) {
                                        Text(guest.name)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 14))
                                            .padding(.bottom, 8)
                                        if let entryDate = formatDate(guest.entry), let exitDate = formatDate(guest.exit) {
                                            Text("ENTRY: \(entryDate)")
                                                .foregroundStyle(Color.black)
                                                .font(.system(size: 12))
                                            
                                            Text("EXIT: \(exitDate)")
                                                .foregroundStyle(Color.black)
                                                .font(.system(size: 12))
                                        }
                                    }
                                    Spacer()
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.black)
                                        .imageScale(.medium)
                                        .onTapGesture {
                                            if let url = URL(string: "tel://\(guest.phone)"), UIApplication.shared.canOpenURL(url) {
                                                UIApplication.shared.open(url)
                                            }
                                        }
                                    Image(systemName: "text.bubble.fill")
                                        .foregroundColor(.black)
                                        .imageScale(.medium)
                                        .padding(.trailing, 10)
                                }
                                    .padding(.leading, 20)
                            )
                            .padding(.horizontal)
                            .padding(.top, 10)
                    }
                    Spacer()
                }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            viewModel.getUserRoomDetails()
        }
    }
    
    //MARK: Owner / Warden
    func Owner_Warden() -> some View {
        VStack {
            if let roomDetails = viewModel.room {
                Rectangle()
                    .frame(width: .infinity, height: 70)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                    .overlay (
                        HStack(spacing: 15) {
                            if let imageUrl = URL(string: roomDetails.room.pgownerid.profileimage) {
                                    AsyncImage(url: imageUrl) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 42, height: 42)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 42, height: 42)
                                    }
                                }
                            VStack(alignment: .listRowSeparatorLeading,spacing: 7) {
                                Text("\(roomDetails.room.pgownerid.name)").fontWeight(.semibold).foregroundColor(.black).font(.system(size: 14))
                                Text("owner").fontWeight(.semibold).foregroundStyle(Color.orange).font(.system(size: 14))
                            }
                            Spacer()
                            Button{
                                if let url = URL(string: "tel://\(roomDetails.room.pgownerid.phone)"), UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                }
                            } label: {
                                Image(systemName: "phone.fill")
                                    .foregroundColor(.black)
                                    .imageScale(.medium)
                            }
                            Image(systemName: "text.bubble.fill").foregroundColor(.black).imageScale(.medium).padding(.trailing, 10)
                            
                        }.padding(.leading, 20)
                    )
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
            
            /*Rectangle()
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
                .padding(.top, 10)*/
        }
    }
    
    //MARK: Room Data
    func RoomID() -> some View {
        VStack {
            Text("My Room").multilineTextAlignment(.center).font(.system(size: 20)).bold()
                .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
            
            HStack {
                if let roomDetails = viewModel.room {
                    Text("Room no:").bold().foregroundStyle(Color.black).font(.system(size: 12.5))
                    Text("\(roomDetails.room.roomnumber)").foregroundStyle(Color.black).font(.system(size: 12.5))
                    Text("Bed no:").bold().foregroundStyle(Color.black).font(.system(size: 12.5))
                    ForEach(roomDetails.room.users, id: \.self) { userDetail in
                        Text("\(userDetail.bedid)").foregroundColor(Color.black).font(.system(size: 12.5))
                    }
                }}}}
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "h:mm a dd-MM-yyyy"
            return dateFormatter.string(from: date)
        }
        return nil
    }

}


struct MyRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MyRoomView()
    }
}
