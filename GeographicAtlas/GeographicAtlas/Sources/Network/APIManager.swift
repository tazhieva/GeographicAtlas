//
//  APIManager.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 13.05.2023.
//

import UIKit

class APIManager {
    
    static let shared = APIManager()
    
    private let baseURL = "https://restcountries.com/v3.1/"
    private let session = URLSession.shared
    
    func getAllCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        let url = URL(string: "\(baseURL)all")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getCountryByCode(code: String, completion: @escaping (Result<Country, Error>) -> Void) {
        let url = URL(string: "\(baseURL)alpha/\(code)")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let country = try decoder.decode(Country.self, from: data)
                completion(.success(country))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

enum APIError: Error {
    case noData
}



