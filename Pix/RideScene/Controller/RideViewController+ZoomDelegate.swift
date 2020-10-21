//
//  RideViewController+ZoomDelegate.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension RideViewController: ZoomDelegate {
   func viewDidZoom(_ view: UIView, scale: CGFloat) {
      if scale > 1 {
         hideControlBars()
         tap.isEnabled = false
      } else {
         showControlBars()
         tap.isEnabled = true
      }
   }
}
