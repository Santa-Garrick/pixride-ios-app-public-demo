//
//  CategoriesFetcher.swift
//  Pix
//
//  Created by Николай Красиков on 11.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


class CategoriesFetcher: CategoriesFetching {
   
   var networkFetcher: CategoriesFetching!
   var defaults: DefaultCategoriesLoading!
   
   func fetch(completion: @escaping (Result<[RideCategory], Error>) -> Void) {
      networkFetcher.fetch { [weak self] (result) in
         guard let self = self else { return }
         
         switch result {
         case .success(let categories):
            completion(.success(categories))
         case .failure(let error):
            print("Error when loading categories from network:", error)
            do {
               let categories = try self.defaults.load()
               completion(.success(categories))
            } catch {
               completion(.failure(error))
            }
         }
      }
   }
}
