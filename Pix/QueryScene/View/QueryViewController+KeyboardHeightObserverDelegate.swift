//
//  QueryViewController+KeyboardHeightObserverDelegate.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension QueryViewController: KeyboardHeightObserverDelegate {
   func keyboardHeightDidChange(height: CGFloat) {
      if (view.frame.maxY - categoriesTableView.frame.maxY) < height {
         let dy = ((view.frame.maxY - categoriesTableView.frame.maxY) - height) - 8
         tableCenterYConstraint.constant = dy
      } else if height == 0 {
         tableCenterYConstraint.constant = 0
      }
   }
   
}
