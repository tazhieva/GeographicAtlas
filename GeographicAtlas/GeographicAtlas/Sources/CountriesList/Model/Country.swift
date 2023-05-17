//
//  Country.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 13.05.2023.
//

import Foundation

// MARK: - Country
struct Country: Codable {
    let name: Name
    let currencies: [String: CurDetails]?
    let capital: [String]?
    let region, subregion: String?
    let area: Double?
    let maps: Maps?
    let population: Int?
    let timezones: [String]?
    let continents: [Continent]?
    let cca2: String?
    let flags: Flags?
    let capitalInfo: CapitalInfo?
    var isExpanded: Bool? 
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Flags
struct Flags: Codable {
    let png: String?
}

// MARK: - Maps
struct Maps: Codable {
    let openStreetMaps: String?
}

// MARK: - Name
struct Name: Codable {
    let common: String
}

struct CurDetails: Codable {
    var name, symbol: String?
}
