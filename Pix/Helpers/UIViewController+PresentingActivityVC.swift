//
//  UIViewController+PresentingActivityVC.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension UIViewController {
   func presentActivityVC(forImage image: UIImage) {
      let ac = makeActivityViewController(forImage: image)
      present(ac, animated: true)
   }
   
   func makeActivityViewController(forImage image: UIImage) -> UIActivityViewController {
      let itemSource = ImageSharingItemSource(withImage: image)
      return UIActivityViewController(activityItems: [image, itemSource],
                                      applicationActivities: nil)
   }
}

