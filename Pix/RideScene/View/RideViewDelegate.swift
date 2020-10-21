//
//  RideViewDelegate.swift
//  Pix
//
//  Created by Pro13 on 14.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//


import UIKit


protocol RideViewDelegate: class {
	func rideView(_ view: RideView,
					  willShowImageAtIndex index: Int)
	func rideView(_ view: RideView,
					  didRemoveImageAtIndex index: Int)
	func rideView(_ view: RideView,
					  didSelectAtIndex index: Int)
	func rideViewDidStopAtTheLast(_ view: RideView)
	func rideViewDidStopAtTheFirst(_ view: RideView)

}

extension RideViewDelegate {
   func rideView(_ view: RideView,
                 willShowImageAtIndex index: Int) {
      
   }
   func rideView(_ view: RideView,
                 didRemoveImageAtIndex index: Int) {
      
   }
   func rideView(_ view: RideView,
                 didSelectAtIndex index: Int) {
      
   }
   func rideViewDidStopAtTheLast(_ view: RideView) {
      
   }
   func rideViewDidStopAtTheFirst(_ view: RideView) {
      
   }
}
