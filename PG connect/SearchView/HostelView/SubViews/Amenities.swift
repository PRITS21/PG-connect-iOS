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
    let amenities: [String]
    
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
                    ForEach(amenities, id: \.self) { amenity in
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.blue.opacity(0.15))
                                Image("tv_icon")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                            }
                            Text("\(amenity)")
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

