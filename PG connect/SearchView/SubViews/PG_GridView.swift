//
//  PG_GridView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 05/03/24.
//
import SwiftUI
import URLImage

struct PG_GridView: View {
    @ObservedObject var viewModel = AuthService.shared
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.pgData) { pgData in
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        VStack {
                            
                            // Display the RemoteImage if available
                            if let firstImage = pgData.images.first, let url = URL(string: firstImage.img) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .frame(width: .infinity, height: 150)
                                           
                                    case .failure:
                                        // Placeholder if image loading fails
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(10)
                                            .shadow(radius: 5)
                                    case .empty:
                                        // Placeholder while loading
                                        ProgressView()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(width: .infinity, height: 150)
                                
                                
                            }
                            VStack(spacing: 0) {
                                HStack {
                                    
                                    Text(pgData.pgname)
                                    
                                        .fontWeight(.medium)
                                        .font(.system(size: 14))
                                    Spacer()
                                }
                                HStack {
                                    HStack(spacing: 2) {
                                        Image(uiImage: UIImage(named: "location_icon_gray")!)
                                            .frame(width: 14, height: 14)
                                        Text(pgData.area)
                                            .font(.system(size: 10))
                                    }
                                    Spacer()
                                }.padding(.bottom, 10)
                                HStack {
                                    HStack(spacing: 2) {
                                        Text("Starts from: ")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 10))
                                        Text("\(pgData.startingfrom)")
                                            .font(.system(size: 10))
                                    }
                                    Spacer()
                                }.padding(.bottom, 10)
                            }.padding(.horizontal)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 4)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 5)
        }
        .onAppear {
            viewModel.fetchPGData()
        }
        
    }
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
}

struct PgResponse: Decodable {
    let pgdata: [PGData]
}


struct PGData: Decodable, Identifiable {
    let id = UUID() // Add a unique identifier
    let _id: String
    var pgname: String
    let city: String
    var area: String
    let pgtype: String
    let roomtype: String
    let roomavailability: RoomAvailability
    var images: [Image2]
    let badges: [String]
    let roomsharingoptions: RoomSharingOptions
    var startingfrom: Int
}

struct RoomAvailability: Decodable {
    let hourly: Bool
    let daily: Bool
    let monthly: Bool
}

struct Image2: Decodable, Identifiable {
    let id = UUID()
    var img: String
}

struct RoomSharingOptions: Decodable {
    let one, two, three, four, five, six, seven, eight, nine, ten: Bool
}


