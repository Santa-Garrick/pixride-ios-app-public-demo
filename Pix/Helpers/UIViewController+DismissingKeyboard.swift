//
//  UIViewController+DismissingKeyboard.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension UIViewController {
   func dismissKeyboardOnTouchOutside() {
      let tapGesture = UITapGestureRecognizer(target: self,
                                              action: #selector(dismissKeyboard))
      tapGesture.cancelsTouchesInView = false
      view.addGestureRecognizer(tapGesture)
   }
   @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
      view.endEditing(true)
   }
}
