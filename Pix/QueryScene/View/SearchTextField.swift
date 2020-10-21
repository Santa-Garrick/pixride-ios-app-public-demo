//
//  SearchTextField.swift
//  Pix
//
//  Created by Pro13 on 28.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {
	
	let imageOffset: CGFloat = 16
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		var rect = super.leftViewRect(forBounds: bounds)
		rect.origin.x += imageOffset
		return rect
	}
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		 var textRect = super.textRect(forBounds: bounds)
		 textRect.origin.x -= imageOffset
		 return textRect
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		 var textRect = super.editingRect(forBounds: bounds)
		 textRect.origin.x -= imageOffset
		 return textRect
	}
	
	private func commonInit() {
		let color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
		let imageView = UIImageView()
		let image = UIImage(systemName: "magnifyingglass")
		imageView.image = image
		imageView.tintColor = color
		leftView = imageView
		leftViewMode = .always
		
		textAlignment = .center
		textColor = .white

      let attr = [NSAttributedString.Key.foregroundColor: color]
		let placeholder = NSAttributedString(string: "Anything", attributes: attr)
		
		attributedPlaceholder = placeholder
		returnKeyType = .go
   }
 
}
