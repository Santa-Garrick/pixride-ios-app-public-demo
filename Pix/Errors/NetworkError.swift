//
//  NetwrokError.swift
//  Pix
//
//  Created by Pro13 on 09.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


enum NetworkError: Error {
   case emptyResponse
   case emptyRequest
   case invalidURL
   case cacheError
   case decodingError
}


extension NetworkError: LocalizedError {
   public var errorDescription: String? {
      switch self {
      case .emptyResponse:
         return NSLocalizedString("Server response is empty.",
                                  comment: "Server response is empty")
      case .emptyRequest:
         return NSLocalizedString("Request is empty.",
                                  comment: "Request is empty")
      case .invalidURL:
         return NSLocalizedString("Can not build URL from string.",
                                  comment: "Can not build URL from string")
      case .cacheError:
         return NSLocalizedString("Cache does not exist or is empty.",
                                  comment: "Cache does not exist or is empty")
      case .decodingError:
         return NSLocalizedString("Can not decode data from server response.",
                                  comment: "Can not decode data from server response")
      }
   }
}

