//
//  CountryListViewModel.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 14.05.2023.
//

import UIKit

class CountryListViewModel {
    
    var countries: [Country] = []
    var countriesByContinent: [Continent: [Country]] = [:]
    
    private let imageCache = URLCache.shared
    
    func getCountries(completion: @escaping () -> Void) {
        let url = "\(Constants.baseURL)all"
        guard let requestUrl = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestUrl) { [weak self] (data, response, error) in
            guard let jsonData = data else {
                print("Error fetching countries: \(error?.localizedDescription ?? "")")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Country].self, from: jsonData)
                self?.countries = decodedData
                for country in decodedData {
                    if let continent = country.continents?.first {
                        if self?.countriesByContinent[continent] == nil {
                            self?.countriesByContinent[continent] = []
                        }
                        self?.countriesByContinent[continent]?.append(country)
                    }
                }
                completion()
            } catch let error {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: urlString) {
            if let cachedResponse = imageCache.cachedResponse(for: URLRequest(url: url)),
               let image = UIImage(data: cachedResponse.data) {
                completion(image)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let imageData = data, let response = response else {
                    completion(nil)
                    return
                }
                
                if let image = UIImage(data: imageData) {
                    let cachedData = CachedURLResponse(response: response, data: imageData)
                    self.imageCache.storeCachedResponse(cachedData, for: URLRequest(url: url))
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            
            task.resume()
        } else {
            completion(nil)
        }
    }
}
