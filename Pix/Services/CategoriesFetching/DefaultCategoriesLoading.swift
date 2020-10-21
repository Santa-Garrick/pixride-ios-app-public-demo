//
//  DefaultCategoriesLoading.swift
//  Pix
//
//  Created by Николай Красиков on 10.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


protocol DefaultCategoriesLoading {
   func load() throws -> [RideCategory]
}

class PlistDefaultCategoriesLoader: DefaultCategoriesLoading {
   
   var defaultsFileName = "DefaultCategories"
   let fileExtension = ".plist"
   
   private var defaultsPath: String? {
      return Bundle.main.path(forResource: defaultsFileName,
                              ofType: fileExtension)
   }
   
   func load() throws -> [RideCategory] {
      
      if let path = defaultsPath,
         let xml = FileManager.default.contents(atPath: path),
         let categories = try? PropertyListDecoder().decode([RideCategory].self, from: xml) {

         return categories
      } else {
         throw DefaultsPlistError.genericError
      }
   }
}

