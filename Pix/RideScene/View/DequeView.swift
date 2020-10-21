//
//  QueueingSubviewView.swift
//  Pix
//
//  Created by Pro13 on 11.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit
 

class DequeView: UIView {
	
   var maxSubviewsNumber: Int = -1
   
   var layoutDelegate: DequeViewLayoutDelegate?
   var animationDuration: Double = 0.3
   
   // this property keeps bounds size during last call of layoutSubviews()
   private var lastBoundsSize: CGSize = .zero

   var cells: [RideViewCell] {
      return subviews as! [RideViewCell]
   }
   
   func pushFront(_ cell: RideViewCell, animated: Bool) {
      addSubview(cell)
      
      let cell = cell
      cell.frame = makeFrame(forCell: cell)
      
      if animated {
         cell.transform = CGAffineTransform(translationX: self.frame.width,
                                            y: 0)
         UIView.animate(withDuration: animationDuration) {
            self.processCells(self.cells)
         }
      } else {
         processCells(self.cells)
      }
	}
	
	func pushBack(_ cell: RideViewCell) {
		insertSubview(cell, at: 0)
      layoutIfNeeded()
	}
	
	func popBack() {
		let bottomView = subviews.first
		bottomView?.removeFromSuperview()
      layoutIfNeeded()
	}
	
   func popFront(animated: Bool) {
      guard let topView = subviews.last else { return }
      let cellsToProcess = Array(cells.dropLast())
      if animated {
         let x = frame.width
         UIView.animate(withDuration: animationDuration) {
            topView.transform = CGAffineTransform(translationX: x, y: 0)
            self.processCells(cellsToProcess)
         } completion: { (_) in
            topView.removeFromSuperview()
         }
      } else {
         topView.removeFromSuperview()
         layoutIfNeeded()
      }
	}
   
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      // if bounds changed: recalculate frames and re-process cells
      if lastBoundsSize != bounds.size {
         _ = cells.map{ $0.frame = makeFrame(forCell: $0)}
         processCells(cells)
         lastBoundsSize = bounds.size
      }
      
   }
   
   private func processCells(_ cells: [RideViewCell]) {
      
      guard let topCell = cells.last else { return }
      
      topCell.transform = .identity
      
      topCell.imageView.alpha = 1.0

      for (i, cell) in cells.reversed().enumerated() where i > 0 {
         let p: CGFloat = CGFloat(i) / CGFloat(self.maxSubviewsNumber)
         let scale = CGAffineTransform(scaleX: (1 - p/2.0), y: (1 - p/2.0))
         cell.transform = scale
         cell.imageView.alpha = 0.2 * (1.0 - p)
      }
   }
   
   private func makeFrame(forCell cell: RideViewCell) -> CGRect {
      
      guard let delegate = layoutDelegate else { return .zero }
      if let frame = delegate.dequeView(self,
                                        frameForItemAtIndex: cell.index) {
         return frame
      } else {
         let initialSize = delegate.dequeView(self, sizeForItemAtIndex: cell.index)
         return self.calculateCenteredFrame(for: initialSize)
      }
   }
}

extension DequeView {
   
   func calculateCenteredFrame(for size: CGSize) -> CGRect {
      
      let widthFactor = frame.width / size.width
      let heightFactor = frame.height / size.height
      
      let scaleFactor = min(widthFactor, heightFactor)
      
      let size = size.scaled(byFactor: scaleFactor)
      
      let originX = (frame.width - size.width) / 2.0
      let originY = (frame.height - size.height) / 2.0
      let origin = CGPoint(x: originX, y: originY)
      
      return CGRect(origin: origin,
                    size: size)
      
   }
   func calculateRandomFrame(for size: CGSize) -> CGRect {

      let size = calculateRandomSize(for: size)
      let origin = calculateRandomOrigin(for: size)

      return CGRect(origin: origin, size: size)
   }
   
   func calculateRandomSize(for size: CGSize) -> CGSize {
      var size = size
      
      let ratio = size.height / self.frame.height
      let targetRatio = CGFloat.random(in: 0.7...1.0)
      
      let scaleFactor = targetRatio / ratio
      
      size = size.scaled(byFactor: scaleFactor)
      
      if size.width > self.frame.width {
         
         let ratio = size.width / self.frame.width
         let targetRatio = CGFloat.random(in: 0.9...1)
         
         let scaleFactor = targetRatio / ratio
         
         size = size.scaled(byFactor: scaleFactor)
         
      }
      
      return size
   }
   
   func calculateRandomOrigin(for size: CGSize) -> CGPoint {
      let selfSize = bounds.size
      
      let maxOriginX = selfSize.width - size.width
      let maxOriginY = selfSize.height - size.height
      
      guard 0 <= maxOriginX, 0 <= maxOriginY else {
         print("Can not calculate proper origin: subview size is bigger than superview size. Setting origin to zero")
         return .zero
      }
      
      let originX = CGFloat.random(in: 0...maxOriginX)
      let originY = CGFloat.random(in: 0...maxOriginY)
      
      return CGPoint(x: originX, y: originY)
   }
}

extension CGSize {
   func scaled(byFactor factor: CGFloat) -> CGSize {
      return CGSize(width: width * factor,
                    height: height * factor)
   }
}
