//
//  RideViewController+RideViewDataSource.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension RideViewController: RideViewDataSource {
   func numberOfImages(in rideView: RideView) -> Int {
      return model.imagesCount
   }
   
   func rideView(_ rideView: RideView, imageViewAtIndex index: Int) -> UIImageView {
      return model[index]
   }
   
   func rideView(_ rideView: RideView, prefetchAtIndex index: Int) {
      model.prefetch(atIndex: index)
   }
   
}
