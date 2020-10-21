//
//  PixabaySearcherWithFakeDelay.swift
//  Pix
//
//  Created by Николай Красиков on 15.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


class PixabaySearcherWithFakeDelay: Searching {
   var timer: Timer?
   
   var isFakingWorstCase: Bool  = false
      
   let searcher = PixabaySearcher()
   
   func setQuery(query: RideQuery) {
      searcher.setQuery(query: query)
   }
   
   func fetchNext(completion: @escaping (Result<[RemoteImage], Error>) -> Void) {
      
      let random = Double.random(in: 0.0...100.0)
      
      let randomDelay = random > 90 ? (15.0 / 10.0) * (random - 90) + 5.0 : (2.0 / 90.0) * random + 3.0
      
      let delay = isFakingWorstCase ? 20.0 : randomDelay
      
      print("\n  Fake delay \(delay) starting...")
      timer = Timer.scheduledTimer(withTimeInterval: delay,
                                   repeats: false,
                                   block: { (timer) in
                                    
                                    print("  Fake delay finished")
                                    self.timer?.invalidate()
                                    self.searcher.fetchNext(completion: completion)
                                   })
   }
   
   func reset() {
      searcher.reset()
   }
   
   
}

