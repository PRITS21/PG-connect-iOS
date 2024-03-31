
import SwiftUI

struct Fitness : Identifiable {
    
    var id : Int
    var pgname : String
    var area : String
    var images: [String]
    var startingfrom: String
    var roomavailability : String
}

// Daily Data...

var fit_Data = [
    
    Fitness(id: 0, pgname: "One hostel", area: "Hyderabad", images: ["room_image 1", "room_image 2", "room_image 3"], startingfrom: "₹2500", roomavailability: "Daily"),
    
    Fitness(id: 1, pgname: "two hostel", area: "Hyderabad", images: ["room_image 2", "room_image 1", "room_image 3"], startingfrom: "₹2500", roomavailability: "Monthly"),
    
    Fitness(id: 2, pgname: "One hostel", area: "Hyderabad", images: ["room_image 2", "room_image 2", "room_image 2"], startingfrom: "₹2500", roomavailability: "Daily"),
    
    Fitness(id: 3, pgname: "One hostel", area: "Hyderabad", images: ["room_image 1", "room_image 2", "room_image 3"], startingfrom: "₹2500", roomavailability: "Daily"),
    
    Fitness(id: 4, pgname: "One hostel", area: "Hyderabad", images: ["room_image 1", "room_image 2", "room_image 3"], startingfrom: "₹2500", roomavailability: "Daily"),
    
    Fitness(id: 5, pgname: "One hostel", area: "Hyderabad", images: ["room_image 1", "room_image 2", "room_image 3"], startingfrom: "₹2500", roomavailability: "Daily"),
    
    Fitness(id: 6, pgname: "One hostel", area: "Hyderabad", images: ["room_image 1", "room_image 2", "room_image 3"], startingfrom: "₹2500", roomavailability: "Daily"),
    
    Fitness(id: 7, pgname: "One hostel", area: "Hyderabad", images: ["room_image 1", "room_image 2", "room_image 3"], startingfrom: "₹2500", roomavailability: "Daily"),
    
]
