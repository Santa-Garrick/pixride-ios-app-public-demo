//
//  Date+Extension.swift
//  Pix
//
//  Created by Николай Красиков on 11.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


extension Date {
   init?(fromHTTPString string: String) {
      let df = DateFormatter.httpDateFormatter
      guard let date = df.date(from: string) else { return nil }
      self = date
   }
}

extension Date {
   func isExpired(for interval: TimeInterval) -> Bool {
      return Date().timeIntervalSince(self) > interval
   }
}
