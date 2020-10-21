//
//  LoadingViewController.swift
//  Pix
//
//  Created by Николай Красиков on 15.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


protocol ActivityIndicating: UIView {
   var hidesWhenStopped: Bool { get set }
   func startAnimating()
   func stopAnimating()
}

class LoadingViewController: UIViewController {
   
   private var timer: Timer?
   private var needsActivityAnimation: Bool = false

   var activityAnimationDelay: TimeInterval = 0.0
   
   var activityIndicator: ActivityIndicating = GLSSpinActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)) {
      didSet {
         setupUI()
      }
   }
   private func setupUI() {
      activityIndicator.center = self.view.center
      activityIndicator.hidesWhenStopped = true
      activityIndicator.startAnimating()
      activityIndicator.stopAnimating()
      view.addSubview(activityIndicator)
   }
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      setupUI()
   }
     
   func startActivityAnimation() {
      needsActivityAnimation = true
      timer = Timer.scheduledTimer(withTimeInterval: activityAnimationDelay,
                                   repeats: false,
                                   block: { [weak self] (timer) in
                                                                        
                                    timer.invalidate()
                                    guard let self = self else {
                                       return
                                    }
                                    if self.needsActivityAnimation {
                                       self.activityIndicator.startAnimating()
                                    }
         
      })
      
   }
   func stopActivityAnimation() {
      needsActivityAnimation = false
      activityIndicator.stopAnimating()
   }
}
