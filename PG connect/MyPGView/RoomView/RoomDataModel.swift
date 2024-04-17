//
//  RoomDetailsResponse.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 07/04/24.
//

import Foundation

struct RoomDetailsResponse: Codable {
    let room: Room
    let employees: [Employee]
    let guests: [Guest]
}

struct Room: Codable {
    let _id: String
    let pgownerid: PgOwner
    let pgid: PgID
    let roomnumber: Int
    let wifiusername: String
    let wifipassword: String
    let users: [UserDetail]
}

struct PgOwner: Codable {
    let _id: String
    let name: String
    let email: String
    let phone: String
    let profileimage: String
}

struct PgID: Codable {
    let _id: String
    let pgname: String
    let gate1: String
    let gate2: String
}

struct UserDetail: Codable, Hashable{
    let user: User
    let bedid: String
}

struct User: Codable, Hashable {
    let _id: String
    let name: String
    let email: String
    let phone: String
    let profileimage: String
}

struct Employee: Codable {
    // Add properties as needed
}

struct Guest: Codable, Hashable {
    let _id: String
    let name: String
    let email: String
    let phone: String
    let entry: String
    let exit: String
}
