//
//  RideViewCell.swift
//  Pix
//
//  Created by Николай Красиков on 10.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit

class RideViewCell: UIView {
   
   var index: Int {
      return tag
   }
   
   var imageView: UIImageView! {
      didSet {
         addSubview(imageView)
         imageView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
         ])
      }
   }
   
   init(withIndex index: Int) {
      self.init()
      self.tag = index
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1215686275, blue: 0.1450980392, alpha: 1)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

extension RideViewCell {
   var isEmpty: Bool {
      return imageView.image != nil
   }
}
