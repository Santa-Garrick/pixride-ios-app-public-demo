//
//  NetworkCategoriesFetcher.swift
//  Pix
//
//  Created by Николай Красиков on 11.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


class NetworkCategoriesFetcher: CategoriesFetching {
   
   var urlString = "https://pixride.com/api/ride-categories"
   
   private var request: URLRequest? {
      guard let url = URL(string: urlString) else { return nil }
      return URLRequest(url: url)
   }
   
   private var session: URLSession {
      return URLSession(configuration: configuration)
   }
   private var configuration = URLSessionConfiguration.default
   private var cache: URLCache? {
      return session.configuration.urlCache
   }
   
   func fetch(completion: @escaping (Result<[RideCategory], Error>) -> Void) {
      
      guard let request = request else {
         completion(.failure(NetworkError.invalidURL))
         return
      }
      
      var cachedCategories: [RideCategory]?
      
      if let cache = cache,
         let cachedResponse = cache.cachedResponse(for: request),
         !(cachedResponse.isExpired ?? true),
         let categories = getCategories(from: cachedResponse.data) {
         print("Loading from cache...")
         completion(.success(categories))
         cachedCategories = categories
         return
      }
      
      session.dataTask(with: request) { [weak self] (data, response, error) in
         guard let self = self else { return }
         
         if let data = data,
            let response = response,
            let categories = self.getCategories(from: data) {
            
            print("Loading from network...")
            completion(.success(categories))
            self.cache?.removeCachedResponse(for: request)
            let cachedResponse = CachedURLResponse(response: response, data: data)
            self.cache?.storeCachedResponse(cachedResponse, for: request)
            
         } else if let categories = cachedCategories {
            print("Loading from cache...")
            completion(.success(categories))
         } else {
            completion(.failure(NetworkError.cacheError))
         }
      }.resume()
   }
   
   private func getCategories(from data: Data) -> [RideCategory]? {
      let decoder = JSONDecoder()
      do {
         let response = try decoder.decode([[RideCategory]].self,
                                           from: data)
         
         return response[0]
      } catch {
         print(error)
         return nil
      }
   }
   
   
}
