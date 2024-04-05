


import Foundation

struct WalletResponse: Codable {
    let wallet: Wallet
}

struct Wallet: Codable {
    let balance: Int
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let amount: Int
    let type: String
    let description: String
    let date: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case amount, type, description, date
        case id = "_id"
    }
}
