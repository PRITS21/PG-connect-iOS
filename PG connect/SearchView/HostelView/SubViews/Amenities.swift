//
//  AmenitiesView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 08/03/24.
//

import SwiftUI

struct AmenityItem: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
}

struct AmenitiesView: View {
    let amenities: [AmenityItem] = [
        AmenityItem(name: "TV", imageName: "tv_icon"),
        AmenityItem(name: "AC", imageName: "tv_icon"),
        AmenityItem(name: "Wi-Fi", imageName: "tv_icon"),
        AmenityItem(name: "Parking", imageName: "tv_icon"),
        
    ]
    
    var body: some View {
        VStack(spacing: 1) {
            HStack {
                Text("Amenities")
                    .font(.system(size: 12.5))
                    .bold()
                    .foregroundStyle(Color.black)
                Spacer()
            }
            
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(amenities) { amenity in
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.blue.opacity(0.15))
                                Image(amenity.imageName)
                                    .resizable()
                                    .frame(width: 15, height: 15)
                            }
                            Text(amenity.name)
                                .font(.system(size: 12))
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
        .padding(.leading)
    }
}


struct AmenitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesView()

    }
}
