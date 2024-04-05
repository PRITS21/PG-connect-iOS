

import Foundation

struct RentTableResponse: Codable {
    let renttable: [Renttable]
    let rentduedate: Int
}

struct Renttable: Codable {
    let month: Int
    let year: Int
    let paid: Bool
    let paidon: String?
    let id: String

    enum CodingKeys: String, CodingKey {
        case month, year, paid, paidon
        case id = "_id"
    }
}
