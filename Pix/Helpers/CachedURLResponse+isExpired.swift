//
//  CachedURLResponse+Extension.swift
//  Pix
//
//  Created by Николай Красиков on 11.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


extension CachedURLResponse {
   var isExpired: Bool? {
      guard let httpResponse = response as? HTTPURLResponse else {
         return nil
      }
      return httpResponse.isExpired
   }
}
