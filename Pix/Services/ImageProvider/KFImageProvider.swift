//
//  KFImageProvider.swift
//  Pix
//
//  Created by Николай Красиков on 14.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit
import Kingfisher


final class KFImageProvider: RemoteImageProvider {
   
   func makeImageView(withRemoteImage image: RemoteImage) -> UIImageView {
      
      let size = image.size
      let frame = CGRect(origin: .zero, size: size)
      let view = UIImageView(frame: frame)
      view.contentMode = .scaleAspectFit
      
      view.kf.setImage(with: image.url, completionHandler: { (_) in
         view.setNeedsLayout()
      })
      return view
   }
   
   func getImage(for url: URL,
                 completion: @escaping (Result<UIImage, Error>) -> Void) {
      KingfisherManager.shared.retrieveImage(with: url) { (result) in
         switch result {
         
         case .success(let imageResult):
            let image = imageResult.image
            completion(.success(image))
         case .failure(let error):
            completion(.failure(error))
         }
      }
      
   }
   
}
