//
//  RideView.swift
//  Pix
//
//  Created by Pro13 on 11.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


class RideView: DequeView {
	
	weak var dataSource: RideViewDataSource?
	weak var delegate: RideViewDelegate?
	
	var prefetchingBufferSize: Int = 25
   private var count: Int = 0

   private var rightSwipe: UISwipeGestureRecognizer!
   private var leftSwipe: UISwipeGestureRecognizer!
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      commonInit()
   }
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      commonInit()
   }
   private func commonInit() {
      rightSwipe = UISwipeGestureRecognizer(target: self,
                                            action: #selector(rightSwipeRecognized))
      rightSwipe.direction = .right
      leftSwipe = UISwipeGestureRecognizer(target: self,
                                           action: #selector(leftSwipeRecognized))
      leftSwipe.direction = .left
      
      addGestureRecognizer(rightSwipe)
      addGestureRecognizer(leftSwipe)
   }
   
   @objc func leftSwipeRecognized(_ sender: UISwipeGestureRecognizer) {
      showNext(shouldSkipEmpty: false, animated: true)
   }
   @objc func rightSwipeRecognized(_ sender: UISwipeGestureRecognizer) {
      showPrevious(shouldSkipEmpty: false, animated: true)
   }
   
	func reloadData() {
		count = dataSource?.numberOfImages(in: self) ?? 0
	}
	
	private func makeCell(for index: Int) -> RideViewCell {
		let contentView = dataSource?.rideView(self, imageViewAtIndex: index) ?? UIImageView()
      let rideViewCell = RideViewCell(withIndex: index)
      rideViewCell.imageView = contentView
      
      return rideViewCell
	}
}

extension RideView {
   var topIndex: Int {
      return cells.last?.index ?? -1
   }
   private var bottomIndex: Int {
      return cells.first?.index ?? -1
   }

   
   private var canShowNext: Bool {
      return topIndex < count - 1
   }
   
   private var shouldRemoveBack: Bool {
      return bottomIndex >= 0 && topIndex > maxSubviewsNumber
   }
   
   private var canShowPrevious: Bool {
      return bottomIndex > 0
   }
   
   private var shouldRemoveFront: Bool {
      return topIndex > 0
   }
      
   func showNext(shouldSkipEmpty: Bool, animated: Bool = true) {
      
      guard canShowNext else {
         delegate?.rideViewDidStopAtTheLast(self)
         return
      }
      
      let indexToShow = topIndex + 1
      let cell = makeCell(for: indexToShow)
      
      if shouldSkipEmpty && cell.isEmpty {
         showNext(shouldSkipEmpty: true)
      }

      delegate?.rideView(self, willShowImageAtIndex: indexToShow)

      pushFront(cell, animated: animated)
      if shouldRemoveBack {
         popBack()
         delegate?.rideView(self,
                            didRemoveImageAtIndex: bottomIndex)
      }

      prefetchIfPossible(atIndex: indexToShow + prefetchingBufferSize)
   }
   
   func showPrevious(shouldSkipEmpty: Bool, animated: Bool = true) {
            
      if canShowPrevious {
         let indexToShow = bottomIndex - 1
         let cell = makeCell(for: indexToShow)
         
         if shouldSkipEmpty && cell.isEmpty {
            showPrevious(shouldSkipEmpty: true)
         }

         delegate?.rideView(self, willShowImageAtIndex: indexToShow)
         pushBack(cell)
         
         prefetchIfPossible(atIndex: indexToShow - prefetchingBufferSize)
      }
      
      guard shouldRemoveFront else { return }
      
      popFront(animated: animated)
      
      delegate?.rideView(self, didRemoveImageAtIndex: topIndex + 1)
   }
   
   private func prefetchIfPossible(atIndex index: Int) {
      if (0 ..< count).contains(index) {
         dataSource?.rideView(self,
                              prefetchAtIndex: index)
      }
   }
}


extension RideView: Zoomable {
   
   var viewForZooming: UIView {
      cells.last ?? UIView()
   }
   
   func switchToZoomingMode(_ zoomingMode: Bool) {
      if zoomingMode {
         showTopViewOnly()
         isUserInteractionEnabled = false
      } else {
         showAllViews()
         isUserInteractionEnabled = true
      }
   }
   
   private func showTopViewOnly() {
      let topIndex = subviews.count - 1
      let subviewsToProccess = Array(subviews[0..<topIndex])
      UIView.animate(withDuration: 0.1) {
         _ = subviewsToProccess.map { $0.alpha = 0 }
      }
   }
   
   private func showAllViews() {
      UIView.animate(withDuration: 0.1) {
         _ = self.subviews.map { $0.alpha = 1 }
      }
   }
   
}
