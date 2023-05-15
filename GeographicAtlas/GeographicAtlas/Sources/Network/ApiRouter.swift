//
//  ApiRouter.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 14.05.2023.
//

import Foundation
import Alamofire

enum ApiRouter {
    case getCoutries
    case getCountryByCca2
    
    private var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getCoutries:
            return "https://restcountries.com/v3.1/all"
        case .getCountryByCca2:
            return "https://restcountries.com/v3.1/alpha/[ssa2_code] "
        }
    }
    private var parameters: [String:Any]? {
        switch self {
        default:
            return [:]
        }
    }
}

