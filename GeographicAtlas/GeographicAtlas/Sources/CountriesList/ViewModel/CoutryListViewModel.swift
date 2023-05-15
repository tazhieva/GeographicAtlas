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
    private let baseUrl = "https://restcountries.com/v3.1/all"
    
    func getCountries(completion: @escaping () -> Void) {
        AF.request(baseUrl).responseJSON { response in
            guard let jsonData = response.data else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Country].self, from: jsonData)
                self.countries = decodedData
                completion()
            } catch let error {
                print("Error decoding JSON: \(error)")
            }
        }
    }
  
}
