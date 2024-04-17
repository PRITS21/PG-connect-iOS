//
//  BookModel.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 13/04/24.
//

import Foundation

struct BookingResponse: Codable {
    let recentbookings: [RecentBooking]
    let pastbookings: [RecentBooking]
}

struct RecentBooking: Codable, Identifiable {
    let id = UUID()
    let _id: String
    let userid: String
    let pgid: PGID
    let roomid: String?
    let bookingtype: String
    let sharingtype: String
    let roomtype: String
    let amount: Int
    let transactionamount: Int
    let status: String
    let razororderid: String
    let paymentstatus: String
    let bookingdate: String
    let amountpayable: Int
    let beds: Int
    let requestaccountrefund: Bool
    let accountrefund: Bool
    let dndbooking: Bool
    let createdAt: String
    let updatedAt: String
    let __v: Int
    
    
}

struct PGID: Codable {
    let _id: String
    let pgname: String
}
