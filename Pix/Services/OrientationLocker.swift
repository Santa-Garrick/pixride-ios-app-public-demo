//
//  OrientationLocker.swift
//  Pix
//
//  Created by Николай Красиков on 21.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit

class OrientationLocker {
   
   class func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
      
      if let delegate = UIApplication.shared.delegate as? AppDelegate {
         delegate.orientationLock = orientation
      }
   }
   
   class func lockOrientation(_ orientation: UIInterfaceOrientationMask,
                              andRotateTo rotateOrientation: UIInterfaceOrientation) {
      
      self.lockOrientation(orientation)
      
      UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
      UINavigationController.attemptRotationToDeviceOrientation()
   }
   
}
