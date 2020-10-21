//
//  UIView+Animate.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit

extension UIView {
   class func animate(withDelay delay: TimeInterval,
                      tension: CGFloat,
                      friction: CGFloat,
                      velocity: CGFloat = 0,
                      mass: CGFloat = 1,
                      options: UIView.AnimationOptions,
                      animations: @escaping () -> Void,
                      completion: ((Bool) -> Void)? = nil) {
      
      let damping = calculateDamping(tension: tension,
                                     friction: friction,
                                     mass: mass)
      let duration = calculateDuration(tension: tension,
                                       friction: friction,
                                       velocity: velocity,
                                       mass: mass)
      
      UIView.animate(withDuration: duration ?? 0.0,
                     delay: delay,
                     usingSpringWithDamping: damping,
                     initialSpringVelocity: velocity,
                     options: options,
                     animations: animations,
                     completion: completion)
   }
   
   class func calculateDamping(tension: CGFloat,
                               friction: CGFloat,
                               mass: CGFloat = 1) -> CGFloat {
      friction / (2 * sqrt(mass * tension))
   }
   
   class func calculateDuration(tension: CGFloat,
                                friction: CGFloat,
                                velocity: CGFloat = 0,
                                mass: CGFloat = 1) -> TimeInterval? {
      let damping = calculateDamping(tension: tension,
                                     friction: friction,
                                     mass: mass)
      
      guard damping < 1 else { return nil }
      
      let undampedFrequency = sqrt(tension / mass)
      let epsilon: CGFloat =  0.001
      
      let a = sqrt(1 - pow(damping, 2))
      let b = velocity / (a * undampedFrequency)
      let c = damping / a
      let d = -((b - c) / epsilon)
      
      guard d > 0 else { return nil }
      
      return TimeInterval(log(d) / (damping * undampedFrequency))
     
   }
   
   
   
}
