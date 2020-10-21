//
//  CGAffineTransform+Extension.swift
//  Pix
//
//  Created by Николай Красиков on 12.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension CGAffineTransform {
   init(from: CGRect, toRect to: CGRect) {
      self.init(translationX: to.midX-from.midX, y: to.midY-from.midY)
      self = self.scaledBy(x: to.width/from.width, y: to.height/from.height)
   }
}
