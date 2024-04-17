//
//  ExpensesDataModel.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 10/04/24.
//

import Foundation

struct Expense: Identifiable, Hashable, Codable {
    
    let id = UUID()
    let _id: String
    let title: String
    let image: URL?
    let expenses: [ExpenseDetail]
}

struct ExpenseDetail: Identifiable, Hashable, Codable {
    let id = UUID()
    let _id: String
    let description: String
    let category: String
    let unitAmount: Int
    let totalAmount: Int
    let date: String
    let image: URL?
    let quantity: Int
    let unit: String
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    var formattedDate: String {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let originalDate = isoDateFormatter.date(from: date) else {
            return ""
        }
        return ExpenseDetail.dateFormatter.string(from: originalDate)
    }

}

// Expenses response data model
struct ExpensesResponse: Decodable {
    let expensesdata: [ExpenseData]
}

// Expense data response model
struct ExpenseData: Decodable {
    let _id: String
    let title: String
    let image: URL?
    let expenses: [ExpenseDetailData]
}

// Expense detail data response model
struct ExpenseDetailData: Decodable {
    let _id: String
    let description: String
    let category: String
    let unitamount: Int
    let totalamount: Int
    let date: String
    let image: URL?
    let quantity: Int
    let unit: String
}
