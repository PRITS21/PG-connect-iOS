//
//  PGDataModel.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 31/03/24.
//

import Foundation

struct PGDetailsResponse: Codable {
    let pgdata: [PGDetailsData]
    let bookingsallowed: BookingsAllowed
    let scheduledvisitsallowed: Bool
    let roomsdata: RoomsData
}

struct PGDetailsData: Codable, Identifiable {
    let id = UUID() // Add a unique identifier
    let roomsharingoptions: RoomSharingOptions
    let roomavailability: RoomAvailability
    let rent: Rent
    let _id: String
    let pgname: String
    let pgaddress: String
    let city: String
    let area: String
    let state: String
    let pgtype: String
    let amenities: [String]
    let images: [Image3]
    let rules: String
    let latitude: String
    let longitude: String
    let nearby: [Nearby]
}


struct Image3: Codable, Identifiable {
    let id = UUID()
    var img: String
}

struct Rent: Codable {
    let monthly, daily, hourly: RentDetails
}

struct RentDetails: Codable {
    let nonac: RentDetailsType
    let ac: RentDetailsType
}

struct RentDetailsType: Codable {
    let maintenance, advance: Int
    let onesharing, twosharing, threesharing, foursharing, fivesharing, sixsharing, sevensharing, eightsharing, ninesharing, tensharing: Int
}

struct Nearby: Codable {
    let name, distance, _id: String
}

struct BookingsAllowed: Codable {
    let monthly, daily, hourly: BookingsAllowedDetails
}

struct BookingsAllowedDetails: Codable {
    let nonac, ac: RoomSharingOptions
}

struct RoomsData: Codable {
    let ac, nonac: RoomDetails
}

struct RoomDetails: Codable {
    let one, two, three, four, five, six, seven, eight, nine, ten: Int
}
