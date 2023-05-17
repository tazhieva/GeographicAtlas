//
//  ImageLoader.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 17.05.2023.
//

import UIKit

class ImageDownloader {
    
    private let imageCache = URLCache.shared
    
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
