//
//  CountryDetailsViewModel.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 16.05.2023.
//

import UIKit
import Alamofire

class CountryDetailsViewModel {
    
    var country: [Country] = []
    
    private let imageCache = URLCache.shared
    
    func getCountryDetails(cca2Code: String, completion: @escaping ([Country]?, Error?) -> Void) {
        let url = "\(Constants.baseURL)alpha/\(cca2Code)" 
        AF.request(url).responseJSON { response in
            guard let jsonData = response.data,
                  let data = jsonData as? Data else {
                return
            }
            do {
                let decodedData = try JSONDecoder().decode([Country].self, from: data)
                self.country = decodedData
                completion(decodedData, nil)
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
