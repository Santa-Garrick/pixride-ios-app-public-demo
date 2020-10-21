//
//  RideCategory.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


struct RideCategory: Decodable {
   let title: String
   let query: String
   
   init(fromCustomTitle title: String) {
      self.title = title
      self.query = title
   }
}
