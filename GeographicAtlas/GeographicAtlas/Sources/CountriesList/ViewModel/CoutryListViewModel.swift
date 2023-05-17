//
//  CountryListViewModel.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 14.05.2023.
//

import UIKit

class CountryListViewModel {
    
    var countriesByContinent: [Continent: [Country]] = [:]
    
    func getCountries(completion: @escaping (Result<Void, GAError>) -> Void) {
        let url = "\(Constants.baseURL)all"
        
        guard let requestUrl = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestUrl) { [weak self] (data, response, error) in
            guard let jsonData = data else {
                completion(.failure(.networkError))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Country].self, from: jsonData)
                for country in decodedData {
                    if let continent = country.continents?.first {
                        if self?.countriesByContinent[continent] == nil {
                            self?.countriesByContinent[continent] = []
                        }
                        self?.countriesByContinent[continent]?.append(country)
                    }
                }
                completion(.success(()))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
