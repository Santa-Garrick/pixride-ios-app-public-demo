//
//  DequeViewLayoutDelegate.swift
//  Pix
//
//  Created by Николай Красиков on 14.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


protocol DequeViewLayoutDelegate: class {
   func dequeView(_ dequeView: DequeView,
                  sizeForItemAtIndex index: Int) -> CGSize
   func dequeView(_ dequeView: DequeView,
                  frameForItemAtIndex index: Int) -> CGRect?
}

extension DequeViewLayoutDelegate {
   func dequeView(_ dequeView: DequeView,
                  frameForItemAtIndex index: Int) -> CGRect? {
      nil
   }
}
