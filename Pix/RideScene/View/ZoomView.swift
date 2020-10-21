//
//  ZoomRideView.swift
//  Pix
//
//  Created by Николай Красиков on 04.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit

protocol ZoomDelegate: class {
   func viewDidZoom(_ view: UIView, scale: CGFloat)
}

protocol Zoomable: UIView {
   var viewForZooming: UIView { get }
   func switchToZoomingMode(_ zoomingMode: Bool)
}

class ZoomView: UIScrollView {
   
   var contentView: Zoomable! {
      didSet {
         contentView.frame = bounds
         addSubview(contentView)
      }
   }
   
   private var doubleTap: UITapGestureRecognizer!
   
   weak var zoomDelegate: ZoomDelegate?
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      commonInit()
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      commonInit()
   }
   private func commonInit() {
      delegate = self

      doubleTap = UITapGestureRecognizer(target: self,
                                         action: #selector(doubleTapRecognized))
      doubleTap.numberOfTapsRequired = 2
      addGestureRecognizer(doubleTap)
      
      showsVerticalScrollIndicator = false
      showsHorizontalScrollIndicator = false
         
      minimumZoomScale = 1
      maximumZoomScale = 1
   }
   
   func enableGestures(_ enable: Bool) {
      contentView.isUserInteractionEnabled = enable
      doubleTap.isEnabled = enable
   }
   
   @objc func doubleTapRecognized(_ sender: UITapGestureRecognizer) {
      
      if zoomScale >= 2 {
         setZoomScale(1, animated: true)
      } else {
         setZoomScale(2 * zoomScale, animated: true)
      }
   }
}

extension ZoomView: UIScrollViewDelegate {
   
   func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return contentView.viewForZooming
   }
   
   private func centerViewForZooming(in scrollView: UIScrollView) {
      let view = viewForZooming(in: scrollView)
      
      let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
      let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
      
      view?.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX,
                             y: scrollView.contentSize.height * 0.5 + offsetY)
   }
   
   func scrollViewDidZoom(_ scrollView: UIScrollView) {
      
      centerViewForZooming(in: scrollView)

      if scrollView.zoomScale > 1.0 {
         clipsToBounds = false
         contentView.switchToZoomingMode(true)
      } else {
         clipsToBounds = true
         contentView.switchToZoomingMode(false)
      }
      zoomDelegate?.viewDidZoom(self, scale: scrollView.zoomScale)
   }
}

extension ZoomView {
   func addUITapGestureRecognizer(_ recognizer: UITapGestureRecognizer) {
      addGestureRecognizer(recognizer)
      recognizer.require(toFail: doubleTap)
   }
}
