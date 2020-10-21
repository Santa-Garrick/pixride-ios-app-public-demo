//
//  HTTPURLResponse+Extension.swift
//  Pix
//
//  Created by Николай Красиков on 11.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


extension HTTPURLResponse {
   var isExpired: Bool {
      
      // check cache-control header first
      if let cacheControl = allHeaderFields["Cache-Control"] as? String,
         let maxAgeString = cacheControl
            .split(separator: ",")
            .filter({ $0.hasPrefix("max-age") })
            .first,
         let maxAge = TimeInterval(String(maxAgeString)),
         let requestDateString = allHeaderFields["Date"] as? String,
         let requestDate = Date(fromHTTPString: requestDateString) {
         
         return requestDate.isExpired(for: maxAge)
      }
      
      // then check expires header
      guard let expDateString = allHeaderFields["Expires"] as? String else {
         return false // if header does not exist response can not be expired
      }
      
      guard let expDate = Date(fromHTTPString: expDateString) else {
         return true // if header contains invalid date response is expired
      }
      
      return expDate <= Date()
   }
}
