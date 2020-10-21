//
//  PlayerViewController.swift
//  Pix
//
//  Created by Pro13 on 08.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


class RideViewController: LoadingViewController, DynamicLayoutReceiver {
   
   var dynamicLayout: DynamicLayout!
  
   var query: RideQuery!
   var model: RideModelProtocol!
   
   let rider = Rider()

   // MARK: constraints
   @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
   @IBOutlet weak var bottomBarHeightConstraint: NSLayoutConstraint!
   @IBOutlet weak var bottomBarLeadingConstraint: NSLayoutConstraint!
   @IBOutlet weak var bottomBarTrailingConstraint: NSLayoutConstraint!
   @IBOutlet weak var rideViewTopConstraint: NSLayoutConstraint!
   @IBOutlet weak var rideViewBottomConstraint: NSLayoutConstraint!
   
   // MARK: outlets
   @IBOutlet weak var topControlBar: TopControlBar!
   @IBOutlet weak var bottomControlBar: BottomControlBar!
   @IBOutlet weak var zoomRideView: ZoomView!
   
   lazy var rideView: RideView = {
      let rideView = RideView()
      rideView.delegate = self
      rideView.dataSource = self
      rideView.layoutDelegate = self
      rideView.maxSubviewsNumber = maxImagesNumber
      return rideView
   }()
   
   var tap: UITapGestureRecognizer!
   
   var maxImagesNumber = 15
   var remoteImagesPrefetchingBufferSize = 50
   
   // MARK: - view lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      
      activityAnimationDelay = 0.5
      setupActivityIndicator()
      
      zoomRideView.zoomDelegate = self
      
      tap = UITapGestureRecognizer(target: self, action: #selector(tapRecognized))
      zoomRideView.addUITapGestureRecognizer(tap)
      
      topControlBar.delegate = self
      topControlBar.dynamicLayout = dynamicLayout
      bottomControlBar.delegate = self
      bottomControlBar.layer.cornerRadius = dynamicLayout.cornerRadius
      bottomControlBar.dynamicLayout = dynamicLayout
      
      rider.view = rideView
      rider.speed = 1
      
      startActivityAnimation()
      model.fetchNewRemotes()
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      zoomRideView.contentSize = zoomRideView.frame.size
      zoomRideView.contentView = rideView
      setupDynamicLayout()
   }
   
   func setupDynamicLayout() {
      rideViewTopConstraint.constant = dynamicLayout.rideViewVerticalInset
      rideViewBottomConstraint.constant = dynamicLayout.rideViewVerticalInset
      topBarHeightConstraint.constant = dynamicLayout.controlBarHeight
      bottomBarHeightConstraint.constant = dynamicLayout.controlBarHeight
      bottomBarTrailingConstraint.constant = dynamicLayout.bottomBarRightInset
   }


   // MARK: - tap actions
   @IBAction func tapRecognized(_ sender: UITapGestureRecognizer) {
      if rider.isRiding {
         switchToPauseMode()
      } else {
         switchToRideMode()
      }
   }
   
   // MARK: - switching between states
   func switchToRideMode() {
      rider.start()
      zoomRideView.enableGestures(false)
      zoomRideView.maximumZoomScale = 1
      hideControlBars()
   }
   
   func switchToPauseMode() {
      rider.stop()
      zoomRideView.enableGestures(true)
      zoomRideView.maximumZoomScale = 4
      showControlBars()
   }
   
   func hideControlBars() {
      topControlBar.isHidden = true
      bottomControlBar.isHidden = true
   }
   
   func showControlBars() {
      topControlBar.isHidden = false
      bottomControlBar.isHidden = false
   }
}

// MARK: - RideModelDelegate

extension RideViewController: RideModelDelegate {
   func modelDidUpdate() {
      DispatchQueue.main.async {
         self.stopActivityAnimation()
         self.switchToRideMode()
         self.rideView.reloadData()
      }
   }
}
