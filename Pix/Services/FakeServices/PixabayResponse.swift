//
//  PixabayResponse.swift
//  Pix
//
//  Created by Pro13 on 15.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit

struct PixabayResponse: Decodable {
   let hits: [PixabayResponseImage]
}

struct PixabayResponseImage: Decodable {
   let largeImageURL: String
   
   let imageWidth: Double
   let imageHeight: Double
   
}

extension PixabayResponseImage: RemoteImage {
   var url: URL {
      return URL(string: largeImageURL)!
   }
   
   var size: CGSize {
      return CGSize(width: imageWidth,
                    height: imageHeight)
   }
}
