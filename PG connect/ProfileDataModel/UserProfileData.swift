//
//  UserProfileData.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 02/04/24.
//

import Foundation

struct UserProfileResponse: Codable {
    let profileid: String
    let name: String
    let email: String
    let phone: String
    let profileimage: String
    let gender: String
    let dnd: Bool
    let alternatenumber: String
    let officehoursstart: String
    let officehoursend: String
    let education: String
    let aadharnumber: String
    let vehiclenumber: String
    let shift: String
    let drivinglicense: String
    let companyname: String
    let occupation: String
    let location: String
    let officeaddress: String
    let prefrences: [String]
    let workingdays: WorkingDays
    let languages: Languages
    let dob: String?
}

struct WorkingDays: Codable {
    let monday: Bool
    let tuesday: Bool
    let wednesday: Bool
    let thursday: Bool
    let friday: Bool
    let saturday: Bool
    let sunday: Bool
}

struct Languages: Codable {
    let mothertongue: [String]
    let secondary: [String]
}
