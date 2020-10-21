//
//  LoadingViewController+Extension.swift
//  Pix
//
//  Created by Николай Красиков on 15.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension LoadingViewController {
   func setupActivityIndicator(withColor color: UIColor = #colorLiteral(red: 0.2032880485, green: 0.2233175337, blue: 0.2400064766, alpha: 1)) {
      let activityIndicator = GLSSpinActivityIndicatorView(frame: CGRect(x: 0,
                                                                         y: 0,
                                                                         width: 100,
                                                                         height: 100))
      activityIndicator.color = color
      self.activityIndicator = activityIndicator
   }
}
