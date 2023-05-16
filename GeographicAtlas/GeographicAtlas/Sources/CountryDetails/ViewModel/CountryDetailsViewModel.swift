//
//  CountryDetailsViewModel.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 16.05.2023.
//

import UIKit

class CountryDetailsViewModel {
    
    var country: [Country] = []
    
    private let imageCache = URLCache.shared
    
    func getCountryDetails(cca2Code: String, completion: @escaping ([Country]?, Error?) -> Void) {
        let url = "\(Constants.baseURL)alpha/\(cca2Code)"
        
        guard let requestUrl = URL(string: url) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            guard let jsonData = data else {
                completion(nil, error)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Country].self, from: jsonData)
                self.country = decodedData
                completion(decodedData, nil)
            } catch let error {
                completion(nil, error)
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
