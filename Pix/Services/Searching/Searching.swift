//
//  Searching.swift
//  Pix
//
//  Created by Pro13 on 09.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


protocol Searching {
   func setQuery(query: RideQuery)
   func fetchNext(completion: @escaping (Result<[RemoteImage], Error>) -> Void)
   func reset()
}
