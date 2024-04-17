//
//  File.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 13/04/24.
//

import Foundation

struct NotificationResponse: Decodable {
    let read: Bool
    let notifications: [Notification]

}

struct Notification: Codable, Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let _id: String
    let date: String
    
}
