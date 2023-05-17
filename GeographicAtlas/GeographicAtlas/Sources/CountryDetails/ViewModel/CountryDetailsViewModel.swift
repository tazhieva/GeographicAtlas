//
//  CountryDetailsViewModel.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 16.05.2023.
//

import UIKit

class CountryDetailsViewModel {
    
    var country: [Country] = []
    
    func getCountryDetails(cca2Code: String, completion: @escaping ([Country]?, GAError?) -> Void) {
        let url = "\(Constants.baseURL)alpha/\(cca2Code)"
        
        guard let requestUrl = URL(string: url) else {
            completion(nil, .invalidURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            guard let jsonData = data else {
                completion(nil, .networkError)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Country].self, from: jsonData)
                self.country = decodedData
                completion(decodedData, nil)
            } catch let error {
                completion(nil, .decodingError)
            }
        }
        
        task.resume()
    }
}
