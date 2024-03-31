//
//  ImageSlideView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 08/03/24.
//

import SwiftUI



struct ImageSlideView: View {
    var fitness: Fitness
    var body: some View {
        
            ImageSlider(images: fitness.images)
                .frame(height: 165)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .cornerRadius(10)
                .padding(.horizontal)
        
    }
}

struct ImageSlider: View {
    let images: [String] // Array of image names
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { item in
                Image(item)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
let sampleFitness2 = Fitness(id: 0, pgname: "One Hostel", area: "Hyderabad", images: ["room_image 1", "room_image 2", "room_image 3"], startingfrom: "₹2500", roomavailability: "Daily")
#Preview {
    ImageSlideView(fitness: sampleFitness2)
}
