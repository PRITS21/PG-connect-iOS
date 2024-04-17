//
//  ScheduleDataModel.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 13/04/24.
//

import Foundation

struct VisitResponse: Decodable {
    let upcomingvisits: [Visit]
    let pastvisits: [Visit]
}

struct Visit: Decodable, Identifiable {
    let id = UUID()
    let _id: String
    let userid: String
    let pgid: PG
    let dateandtime: String
    let status: String
    let noofpersons: Int
    let createdAt: String
    let updatedAt: String
    let __v: Int

}

struct PG: Decodable {
    let _id: String
    let pgname: String

}

