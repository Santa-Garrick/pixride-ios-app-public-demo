//
//  ImageCache+Extension.swift
//  Pix
//
//  Created by Николай Красиков on 09.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation
import Kingfisher

extension ImageCache {
   func configureCacheLimits(countLimit: Int = 70,
                             sizeLimit: UInt = 1000 * 1024 * 1024) {
      let cache = self
      
      cache.memoryStorage.config.countLimit = countLimit
      cache.diskStorage.config.sizeLimit = sizeLimit
   }
}
