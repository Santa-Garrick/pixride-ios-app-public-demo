//
//  DateFormatter+Extension.swift
//  Pix
//
//  Created by Николай Красиков on 11.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


extension DateFormatter {
   static var httpDateFormatter: DateFormatter {
      let df = DateFormatter()
      df.dateFormat = "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz"
      df.locale = Locale(identifier: "en_US_POSIX")
      return df
   }
}


