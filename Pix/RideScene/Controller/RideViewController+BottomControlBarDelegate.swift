//
//  RideViewController+BottomControlBarDelegate.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension RideViewController: BottomControlBarDelegate {
   func speedChanged(_ value: Double) {
      rider.speed = value
   }
   
   func playTapped() {
      switchToRideMode()
   }
}
