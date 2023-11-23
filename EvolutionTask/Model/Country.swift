//
//  Country.swift
//  EvolutionTask
//
//  Created by Luka on 20.11.2023..
//

import Foundation

struct Country: Codable, Identifiable {
    var id: String {
        UUID().uuidString
    }
    var name: CountryName
    var capital: [String]?
    var region: String
    var borders: [String]?
    var latLng: [Int]?
    var maps: Map
    var population: Int
    var timezones: [String]
    var flags: Flag
    var currencies: [String : Currency]?
    var languages: [String: String]?
    var area: Int
    var coatOfArms: CoatOfArms
    var cca3: String
}

struct CountryName: Codable {
    var common: String
    var official: String
}

struct Map: Codable {
    var googleMaps: String
}

struct Flag: Codable {
    var png: String
}

struct Currency: Codable {
    var name: String
}

struct CoatOfArms: Codable {
    var png: String
}


