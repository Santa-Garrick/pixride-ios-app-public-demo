//
//  KeyboardHeightObserver.swift
//  Pix
//
//  Created by Pro13 on 29.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


protocol KeyboardHeightObserverDelegate: class {
   func keyboardHeightDidChange(height: CGFloat)
}

class KeyboardHeightObserver {
   weak var delegate: (UIViewController & KeyboardHeightObserverDelegate)?
   init() {
      NotificationCenter
         .default
         .addObserver(self,
                      selector: #selector(self.keyboardNotification(notification:)),
                      name: UIResponder.keyboardWillChangeFrameNotification,
                      object: nil)
   }
   deinit {
      NotificationCenter.default.removeObserver(self)
   }
   @objc func keyboardNotification(notification: NSNotification) {
      
      guard let userInfo = notification.userInfo else { return }
      
      let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      let endFrameY = endFrame?.origin.y ?? 0
      let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
      let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
      let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
      let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
      
      if endFrameY >= UIScreen.main.bounds.size.height {
         delegate?.keyboardHeightDidChange(height: 0.0)
      } else {
         delegate?.keyboardHeightDidChange(height: endFrame?.size.height ?? 0.0)
      }
      UIView.animate(withDuration: duration,
                     delay: TimeInterval(0),
                     options: animationCurve,
                     animations: { self.delegate?.view.layoutIfNeeded() })
   }
}
