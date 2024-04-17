//
//  DNDResponseModel.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 06/04/24.
//

import Foundation

struct DNDResponse: Codable {
    let pastdnd: [DNDItem]
    let ongoingdnd: [DNDItem]
    let pendingdnd: [DNDItem]
    
}

struct DNDItem: Codable, Identifiable {
    let id = UUID()
    let _id: String
    let startdate: String
    let expectedreturndate: String
    let returningmeal: String
    let days: Int // Add days property
    
    
    var formattedStartDate: String {
        return formatDate(dateString: startdate)
    }
    
    var formattedReturnDate: String {
        return formatDate(dateString: expectedreturndate)
    }
    
    private func formatDate(dateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        return outputFormatter.string(from: date)
    }
}

struct DNDModification: Codable {
    let expectedreturndate: String
    let returningmeal: String
}
