//
//  RideViewController+DequeViewLayoutDelegate.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension RideViewController: DequeViewLayoutDelegate {
   func dequeView(_ dequeView: DequeView, sizeForItemAtIndex index: Int) -> CGSize {
      return model[index].frame.size
   }
}
