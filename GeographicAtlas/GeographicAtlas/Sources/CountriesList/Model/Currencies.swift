//
//  Currencies.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 16.05.2023.
//

import Foundation

struct Currencies: Codable {
    let afn: Afn?

    enum CodingKeys: String, CodingKey {
        case afn = "AFN"
    }
}

struct Afn: Codable {
    let name, symbol: String?
}
