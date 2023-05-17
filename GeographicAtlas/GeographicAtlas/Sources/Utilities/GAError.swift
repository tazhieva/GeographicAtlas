//
//  GAError.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 17.05.2023.
//

import Foundation

import Foundation

enum GAError: Error {
    case invalidURL
    case decodingError
    case networkError
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "The provided URL is not valid."
        case .decodingError:
            return "An error occurred while decoding the data."
        case .networkError:
            return "A network error occurred."
        }
    }
}
