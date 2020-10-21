//
//  KFImagePrefetcher.swift
//  Pix
//
//  Created by Николай Красиков on 14.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//


import Foundation
import Kingfisher


final class KFImagePrefetcher: ImagePrefetching {
   
   var treshold: Int = 25
   
   func prefetch(urls: [URL]) {
      let prefetcher = ImagePrefetcher(urls: urls)
      prefetcher.start()
   }
   
   func prefetch(urls: [URL], completion: @escaping (_ success: Bool) -> Void) {
      var success: Bool = false
      ImagePrefetcher(urls: urls) { [weak self] (skipped, failed, completed) in
         if success { return }
         
         let readyCount = completed.count + skipped.count
         if let treshold = self?.treshold, readyCount >= treshold {
            completion(true)
            success = true
         }
      } completionHandler: { (skipped, failed, completed) in
         if success { return }
         completion(false)
      }.start()
   }
}
