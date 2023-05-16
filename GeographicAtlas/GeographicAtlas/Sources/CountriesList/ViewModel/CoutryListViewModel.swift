//
//  CountryListViewModel.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 14.05.2023.
//

import UIKit
import Alamofire

class CountryListViewModel {
    
    var countries: [Country] = []
    
    private let url = "\(Constants.baseURL)all"
    private let imageCache = URLCache.shared
    
    var countriesByContinent: [Continent: [Country]] = [:]
    
    func getCountries(completion: @escaping () -> Void) {
        AF.request(url).responseJSON { response in
            guard let jsonData = response.data,
                  let data = jsonData as? Data else {
                return
            }
            do {
                let decodedData = try JSONDecoder().decode([Country].self, from: data)
                self.countries = decodedData
                for country in self.countries {
                    if let continent = country.continents?.first {
                        if self.countriesByContinent[continent] == nil {
                            self.countriesByContinent[continent] = []
                        }
                        self.countriesByContinent[continent]?.append(country)
                    }
                }
                completion()
            } catch let error {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
           if let url = URL(string: urlString) {
               // Проверяем, есть ли изображение в кэше
               if let cachedResponse = imageCache.cachedResponse(for: URLRequest(url: url)),
                  let image = UIImage(data: cachedResponse.data) {
                   completion(image)
                   return
               }

               // Если изображения нет в кэше, загружаем его
               AF.request(url).responseData { response in
                   switch response.result {
                   case .success(let data):
                       if let image = UIImage(data: data) {
                           // Сохраняем изображение в кэше
                           let cachedData = CachedURLResponse(response: response.response!,
                                                              data: data)
                           self.imageCache.storeCachedResponse(cachedData, for: URLRequest(url: url))
                           
                           completion(image)
                       } else {
                           completion(nil)
                       }
                   case .failure:
                       completion(nil)
                   }
               }
           } else {
               completion(nil)
           }
       }
   
}

