//
//  AppDelegate.swift
//  Pix
//
//  Created by Pro13 on 07.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit
import Kingfisher


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   var orientationLock = UIInterfaceOrientationMask.all
   
   func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Configure cache limits with default values
      ImageCache.default.configureCacheLimits()
      return true
   }
   
   func application(_ application: UIApplication,
                    supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
      return self.orientationLock
   }
   
   func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      
      return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
   }
   
   
}

