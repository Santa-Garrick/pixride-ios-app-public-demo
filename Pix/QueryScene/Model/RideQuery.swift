//
//  RideQuery.swift
//  Pix
//
//  Created by Pro13 on 10.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


struct RideQuery {
	var queries: [String] = []
   init(fromCategories categories: [RideCategory]) {
      self.queries = categories.map{ $0.query }
   }
}
