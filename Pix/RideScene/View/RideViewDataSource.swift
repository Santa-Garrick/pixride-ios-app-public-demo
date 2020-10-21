//
//  RideViewDataSource.swift
//  Pix
//
//  Created by Pro13 on 14.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//


import UIKit


protocol RideViewDataSource: class {
	func numberOfImages(in rideView: RideView) -> Int
	func rideView(_ rideView: RideView,
					  imageViewAtIndex index: Int) -> UIImageView
	
	func rideView(_ rideView: RideView,
					  prefetchAtIndex index: Int)
}

extension RideViewDataSource {
   func rideView(_ rideView: RideView,
                 prefetchAtIndex index: Int) {
      
   }
}
