//
//  PixabaySearcher.swift
//  Pix
//
//  Created by Николай Красиков on 14.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


final class PixabaySearcher: Searching {
   
   private var query: RideQuery?
   private var pixabayQuery: String? {
      guard let query = query else { return nil }
      return query.queries.reduce("") { $0 + $1 }
   }
   
   private let per_page = 80
   private var page = 1
   
   private var baseComponents: URLComponents {
      var components = URLComponents()
      
      components.scheme = "https"
      components.host = "pixabay.com"
      components.path = "/api/"
      
      let keyQueryItem = URLQueryItem(name: "key", value: "18281684-d57c33b0209728686349a30aa")
      
      let countQueryItem = URLQueryItem(name: "page", value: "\(page)")
      let offsetQueryItem = URLQueryItem(name: "per_page", value: "\(per_page)")
      
      let queryItems = [
         keyQueryItem,
         countQueryItem,
         offsetQueryItem
      ]
      components.queryItems = queryItems
      return components
   }
   
   func setQuery(query: RideQuery) {
      self.query = query
   }
   
   func reset() {
      page = 1
   }
   
   func fetchNext(completion: @escaping (Result<[RemoteImage], Error>) -> Void) {
      guard let pixabayQuery = pixabayQuery else {
         completion(.failure(NetworkError.emptyRequest))
         return
      }
            
      let queryTermQueryItem = URLQueryItem(name: "q", value: pixabayQuery)
      
      var components = baseComponents
      components.queryItems?.append(queryTermQueryItem)
      
      guard let url = components.url else {
         completion(.failure(NetworkError.invalidURL))
         return
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      
      let session = URLSession.shared
      
      let task = session.dataTask(with: request) { [weak self] (data, response, error) in
         
         guard
            let data = data,
            let httpResponse = response as? HTTPURLResponse,
            error == nil
         else {
            completion(.failure(NetworkError.emptyResponse))
            return
         }
         
         guard 200 ..< 300 ~= httpResponse.statusCode else {
            completion(.failure(NetworkError.emptyResponse))
            return
         }
         
         
         guard let urls = self?.urlsFrom(data) else {
            completion(.failure(NetworkError.decodingError))
            return
         }
         completion(.success(urls))
         
      }
      task.resume()
      
      page += 1
   }
   private func urlsFrom(_ data: Data) -> [RemoteImage]? {
      let decoder = JSONDecoder()
      
      do {
         let urls = try decoder.decode(PixabayResponse.self,
                                       from: data)
         return urls.hits.map { $0 }.compactMap { $0 }
      } catch (let error) {
         print(error)
         return nil
      }
   }
}
