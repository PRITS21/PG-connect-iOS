//
//  PGDataModel.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 31/03/24.
//

import Foundation

struct PGDetailsResponse: Codable {
    let pgdata: PGDetailsData
    let bookingsallowed: BookingsAllowed
    let scheduledvisitsallowed: Bool
    let roomsdata: RoomsData
    
}

struct PGDetailsData: Codable, Identifiable {
    let id = UUID()
    let roomsharingoptions: [String: Bool]
    let roomavailability: RoomAvailability2
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


struct RoomAvailability2: Codable {
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

struct Rent: Codable {
    let monthly, daily, hourly: RentType
    
    
}

struct RentType: Codable {
    let nonac, ac: RentDetails
}

struct RentDetails: Codable {
    let maintenance, advance, onesharing, twosharing, threesharing, foursharing, fivesharing, sixsharing, sevensharing, eightsharing, ninesharing, tensharing: Int?
    
    var otherOptions: [(String, Int)] {
            var options: [(String, Int)] = []
            if let maintenance = maintenance, maintenance > 0 {
                options.append(("Maintenance", maintenance))
            }
            if let advance = advance, advance > 0 {
                options.append(("Advance", advance))
            }
            return options
        }

    var availableOptions: [(String, Int)] {
        var options: [(String, Int)] = []
        if let oneSharing = onesharing, oneSharing > 0 {
            options.append(("1 sharing", oneSharing))
        }
        if let twoSharing = twosharing, twoSharing > 0 {
            options.append(("2 sharing", twoSharing))
        }
        if let threeSharing = threesharing, threeSharing > 0 {
            options.append(("3 sharing", threeSharing))
        }
        if let fourSharing = foursharing, fourSharing > 0 {
            options.append(("4 sharing", fourSharing))
        }
        if let fiveSharing = fivesharing, fiveSharing > 0 {
            options.append(("5 sharing", fiveSharing))
        }
        if let sixSharing = sixsharing, sixSharing > 0 {
            options.append(("6 sharing", sixSharing))
        }
        if let sevenSharing = sevensharing, sevenSharing > 0 {
            options.append(("7 sharing", sevenSharing))
        }
        if let eightSharing = eightsharing, eightSharing > 0 {
            options.append(("8 sharing", eightSharing))
        }
        if let nineSharing = ninesharing, nineSharing > 0 {
            options.append(("9 sharing", nineSharing))
        }
        if let tenSharing = tensharing, tenSharing > 0 {
            options.append(("10 sharing", tenSharing))
        }
        return options
    }
    func hasSharingRentInRange(range: ClosedRange<Int>) -> Bool {
            let allSharingRentValues = [onesharing, twosharing, threesharing, foursharing, fivesharing, sixsharing, sevensharing, eightsharing, ninesharing, tensharing]
            
            for sharingRentValue in allSharingRentValues {
                if let rent = sharingRentValue, range.contains(rent) {
                    return true
                }
            }
            return false
        }
}

struct Image3: Codable, Hashable {
    let img: String
}

struct Nearby: Codable, Hashable {
    let name: String
    let distance, _id: String
}

struct BookingsAllowed: Codable {
    let monthly, daily, hourly: BookingsType
}

struct BookingsType: Codable {
    let nonac, ac: BookingsDetails
}

struct BookingsDetails: Codable {
    let onesharing, twosharing, threesharing, foursharing, fivesharing, sixsharing, sevensharing, eightsharing, ninesharing, tensharing: Bool
}

struct RoomsData: Codable {
    let ac, nonac: RoomDetails
}

struct RoomDetails: Codable {
    let one, two, three, four, five, six, seven, eight, nine, ten: Int
}
