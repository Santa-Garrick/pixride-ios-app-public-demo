//
//  QueryDisplaying.swift
//  Pix
//
//  Created by Николай Красиков on 09.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


protocol QueryDisplaying: class {
   func setCategories(_ categories: [String])
   func setSelected(atIndex index: Int)
   func setDeselected(atIndex index: Int)
   func resetCustomQuery()
}
