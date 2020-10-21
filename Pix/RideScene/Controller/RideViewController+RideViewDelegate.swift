//
//  RideViewController+RideViewDelegate.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension RideViewController: RideViewDelegate {
   func rideViewDidStopAtTheLast(_ view: RideView) {
      rider.stop()
      startActivityAnimation()
   }
   
   func rideViewDidStopAtTheFirst(_ view: RideView) {
      rider.stop()
   }
   func rideView(_ view: RideView, willShowImageAtIndex index: Int) {
      if model.imagesCount - index == remoteImagesPrefetchingBufferSize {
         model.fetchNewRemotes()
      }
   }
}
