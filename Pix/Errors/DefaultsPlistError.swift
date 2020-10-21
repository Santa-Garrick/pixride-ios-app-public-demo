//
//  LocalCacheError.swift
//  Pix
//
//  Created by Николай Красиков on 10.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


public enum DefaultsPlistError: Error {
   case genericError
}

extension DefaultsPlistError: LocalizedError {
   public var errorDescription: String? {
      switch self {
      case .genericError:
         return NSLocalizedString("Can not load default categories from plist.", comment: "Can not load default categories from plist")
      }
   }
}

