//
//  ImageViewFactory.swift
//  Pix
//
//  Created by Pro13 on 13.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


protocol RemoteImageProvider {
   func makeImageView(withRemoteImage image: RemoteImage) -> UIImageView
   func getImage(for url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}
