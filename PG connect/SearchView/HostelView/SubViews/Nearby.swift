//
//  nearbyview.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 09/03/24.
//

import SwiftUI


struct NearbyView: View {
    let nearbyPlaces: [Nearby]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Nearby Places")
                    .font(.system(size: 12.5))
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
                Spacer()
            }
            .padding(.top, 2)
            
            ForEach(nearbyPlaces, id: \.self) { place in
                NearbyLocationView(nearby: place.name, distance: place.distance)
            }
        }
        .padding(.leading)
        .padding([.top,.bottom], 10)
    }
}

struct NearbyLocationView: View {
    let nearby: String
    var distance: String
    var body: some View {
        HStack {
            HStack(spacing: 2) {
                Image(uiImage: UIImage(named: "location_icon_gray")!)
                    .resizable()
                    .frame(width: 14, height: 14)
                Text(nearby)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
            }.padding(.top, 2)
            
            Spacer()
            Text("\(distance) KM")
                .font(.system(size: 12))
                .bold()
                .padding(.trailing)
        }
        
    }
}
