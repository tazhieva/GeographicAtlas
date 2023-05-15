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
    
    var countriesByContinent: [Continent: [Country]] = [:]
    
    func getCountries(completion: @escaping () -> Void) {
        AF.request(baseUrl).responseJSON { response in
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
                print("Error decoding JSON: \(error)")
            }
        }
    }
}

