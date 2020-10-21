//
//  CategoryCell.swift
//  Pix
//
//  Created by Pro13 on 10.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


class CategoryCell: UITableViewCell, DynamicLayoutReceiver {
   
   var dynamicLayout: DynamicLayout!
   func setupDynamicLayout() {
      topConstraint.constant = dynamicLayout.cellLabelInsets
      bottomConstraint.constant = dynamicLayout.cellLabelInsets
      titleHeightConstraint.constant = dynamicLayout.cellLabelHeight
      titleLabel.font = dynamicLayout.font
   }
   var separatorEnabled: Bool = false {
		didSet {
			separatorView.isHidden = !separatorEnabled
		}
	}
	
   override func layoutSubviews() {
      super.layoutSubviews()
      setupDynamicLayout()
   }
   
   @IBOutlet weak var topConstraint: NSLayoutConstraint!
   @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
   @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!

   @IBOutlet weak var selectedImageView: UIImageView!
   @IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var separatorView: UIView!
	   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
		let duration: TimeInterval = animated ? 0.1 : 0
		if selected {
			UIView.animate(withDuration: duration) {
				self.selectedImageView.alpha = 1
				self.titleLabel.alpha = 1
			}
      } else {
			UIView.animate(withDuration: duration) {
				self.selectedImageView.alpha = 0
				self.titleLabel.alpha = 0.4
			}
      }
   }
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)
      
      if let view = (superview as? AnimatedTableView) {
         view.animateTouching()
      }
   }
   
   
}

