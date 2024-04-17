//
//  RazorpayModel.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 14/04/24.
//
import Foundation

struct RazorpayOrder: Codable {
    let name: String
    let email: String
    let phone: String
    let razorpayorder: RazorpayOrderDetails
}

struct RazorpayOrderDetails: Codable {
    let amount: Int
    let amount_due: Int
    let amount_paid: Int
    let created_at: Int
    let currency: String
    // Add other properties as needed
}

