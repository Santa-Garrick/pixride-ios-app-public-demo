//
//  ImageSharingItemSource.swift
//  Pix
//
//  Created by Николай Красиков on 14.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit
import Kingfisher
import LinkPresentation


final class ImageSharingItemSource: NSObject, UIActivityItemSource {
   let image: UIImage
   
   init(withImage image: UIImage) {
      self.image = image
   }
   
   func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
      return ""
   }
   
   func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
      return nil
   }
   
   func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
      let imageProvider = NSItemProvider(object: image)
      let metadata = LPLinkMetadata()
      metadata.imageProvider = imageProvider
      return metadata
   }
}
