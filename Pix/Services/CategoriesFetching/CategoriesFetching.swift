//
//  CategoriesFetching.swift
//  Pix
//
//  Created by Николай Красиков on 09.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


protocol CategoriesFetching {
   func fetch(completion: @escaping (Result<[RideCategory], Error>) -> Void)
}
