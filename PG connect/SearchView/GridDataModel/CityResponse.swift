//
//  CityResponse.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 13/04/24.
//
import Foundation

struct StateAndCity: Codable {
    let statesandcities: StatesAndCities
}

struct StatesAndCities: Codable {
    let Telangana: [City]?
    let Karnataka: [City]?
    let TamilNadu: [City]?
}

struct City: Codable {
    let city: String
}
