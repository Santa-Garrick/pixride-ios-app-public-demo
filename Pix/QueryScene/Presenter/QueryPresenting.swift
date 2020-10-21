//
//  QueryPresenting.swift
//  Pix
//
//  Created by Николай Красиков on 09.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


protocol QueryPresenting {
   var view: QueryDisplaying? { get set }
   var query: RideQuery { get }
   
   func getCategories()
   func select(atIndex index: Int)
   func deselect(atIndex index: Int)
   func setCustomQuery(_ query: String)
}
