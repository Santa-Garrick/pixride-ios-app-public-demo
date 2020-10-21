//
//  AnimatedTableView.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit

class AnimatedTableView: UITableView {
   
   var tension: CGFloat = 300
   var friction: CGFloat = 20
      
   func animateTouching() {
      UIView.animate(withDelay: 0.0,
                     tension: tension,
                     friction: friction,
                     options: .allowUserInteraction) {
         self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
      }
      UIView.animate(withDelay: 0.1,
                     tension: tension,
                     friction: friction,
                     options: .allowUserInteraction) {
         self.transform = .identity
      }
   }
}
