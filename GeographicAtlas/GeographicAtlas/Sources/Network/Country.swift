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
    let currencies: Currencies?
    let capital: [String]?
    let region, subregion: String?
    let area: Double?
    let maps: Maps?
    let population: Int?
    let timezones: [String]?
    let continents: [Continent]?
    let flags: Flags?
    let capitalInfo: CapitalInfo?
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - Currencies
struct Currencies: Codable {
    let afn: Afn?

    enum CodingKeys: String, CodingKey {
        case afn = "AFN"
    }
}

// MARK: - Afn
struct Afn: Codable {
    let name, symbol: String?
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
