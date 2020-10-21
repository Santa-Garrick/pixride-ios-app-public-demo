//
//  FakeNetworkCategoriesFetcher.swift
//  Pix
//
//  Created by Николай Красиков on 15.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation



class FakeNetworkCategoriesFetcher: CategoriesFetching {
   var timer: Timer?
   
   let delayRange: Range<TimeInterval>
   
   var randomDelay: TimeInterval {
      return Double.random(in: delayRange)
   }
   
   init(delayRange: Range<TimeInterval>) {
      self.delayRange = delayRange
   }
   
   func fetch(completion: @escaping (Result<[RideCategory], Error>) -> Void) {
      
      timer = Timer.scheduledTimer(withTimeInterval: randomDelay,
                                   repeats: false,
                                   block: { (timer) in
         self.timer?.invalidate()
         self.fetcher.fetch(completion: completion)
      })
   }
   
   let fetcher = NetworkCategoriesFetcher()
   
}
