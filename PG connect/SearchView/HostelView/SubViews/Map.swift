//
//  MapView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 09/03/24.
//
import SwiftUI
import MapKit

struct MapView: View {
    @State private var locationText: String = "J.B.S. Haldane Avenue, Kolkata-700 046, West Bengal, India"
    let latitude: Double
    let longitude: Double

    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            HStack {
                Text("Address")
                    .font(.system(size: 12.5))
                    .bold()
                    .foregroundStyle(Color.black)
                Spacer()
            }.padding(.top, 2)
            
            Text(locationText)
                .font(.system(size: 11.5))
                .fontWeight(.medium)
                .foregroundStyle(Color.black)
                .lineLimit(2)
                .padding(.top, 7)
            
            MapBox(latitude: latitude, longitude: longitude)
                .frame(width: .infinity, height: 210)
                .cornerRadius(10)
                .padding([.top,.bottom], 15)
        }.padding([.leading, .trailing])
    }
}

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}

struct MapBox: View {
    @State private var region: MKCoordinateRegion
    let markers: [Marker]

    init(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self._region = State(initialValue: MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.001)))
        self.markers = [Marker(location: MapMarker(coordinate: coordinate, tint: .red))]
    }

    var body: some View {
        VStack {
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: markers) { marker in
                marker.location
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(latitude: 22.50108, longitude: 88.36176)
    }
}
