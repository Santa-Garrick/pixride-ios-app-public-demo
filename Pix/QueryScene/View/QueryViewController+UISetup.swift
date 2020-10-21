//
//  QueryViewController+UISetup.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension QueryViewController {
   func setupTableView() {
      categoriesTableView.register(UINib(nibName: cellID,
                                         bundle: nil),
                                   forCellReuseIdentifier: cellID)
      categoriesTableView.layer.cornerRadius = 24
      categoriesTableView.layer.masksToBounds = true
      
      
   }
   func setupStartButton() {
      startRideButton.layer.cornerRadius = 24
      startRideButton.layer.masksToBounds = true
   }
}
