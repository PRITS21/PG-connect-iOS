//
//  UserProfileModel.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 04/04/24.
//

import Foundation


struct UserProfile2: Codable {
    var alternatenumber: String?
    var foodtype: String?
    var officehoursstart: String?
    var officehoursend: String?
    var education: String?
    var aadharnumber: String?
    var vehiclenumber: String?
    var shift: String?
    var drivinglicense: String?
    var companyname: String?
    var occupation: String?
    var location: String?
    var officeaddress: String?
    var prefrences: [String]?
    var workingdays: WorkingDays_user?
    var languages: Languages_user?
}


struct WorkingDays_user: Codable {
    var monday: Bool
    var tuesday: Bool
    var wednesday: Bool
    var thursday: Bool
    var friday: Bool
    var saturday: Bool
    var sunday: Bool
}

struct Languages_user: Codable {
    var mothertongue: [String]
    var secondary: [String]
}
