//
//  QueryViewController+QueryDisplaying.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension QueryViewController: QueryDisplaying {
   func resetCustomQuery() {
      textFieldView.resetText()
   }
   
   func setCategories(_ categories: [String]) {
      stopActivityAnimation()
      self.categories = categories
      categoriesTableView.reloadData()
   }
   func setSelected(atIndex index: Int) {
      categoriesTableView.selectRow(at: IndexPath(row: index, section: 0),
                                    animated: true,
                                    scrollPosition: .none)
   }
   func setDeselected(atIndex index: Int) {
      categoriesTableView.deselectRow(at: IndexPath(row: index, section: 0),
                                      animated: true)
   }
}

