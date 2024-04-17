//
//  PGdata.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 31/03/24.
//

import Foundation

struct PgResponse: Codable {
    let pgdata: [PGData]

}

struct PGData: Codable, Identifiable {
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

struct RoomAvailability: Codable {
    let hourly: Bool
    let daily: Bool
    let monthly: Bool
    
    var availableOptions: [String] {
        var options: [String] = []
        if hourly {
            options.append("Hourly")
        }
        if daily {
            options.append("Daily")
        }
        if monthly {
            options.append("Monthly")
        }
        return options
    }
}


struct Image2: Codable, Identifiable {
    let id = UUID()
    var img: String
}

struct RoomSharingOptions: Codable {
    let one, two, three, four, five, six, seven, eight, nine, ten: Bool
}


