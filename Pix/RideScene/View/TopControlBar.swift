//
//  TopControlBar.swift
//  Pix
//
//  Created by Pro13 on 29.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


protocol TopControlBarDelegate: class {
	func exitTapped()
	func activitiesTapped()
	func downloadTapped()
}

class TopControlBar: UIView, DynamicLayoutReceiver {
   var dynamicLayout: DynamicLayout!
   override func layoutSubviews() {
      super.layoutSubviews()
      setupDynamicLayout()
   }
   func setupDynamicLayout() {
      
      let buttonSize = dynamicLayout.controlBarHeight
      let cornerRadius = dynamicLayout.cornerRadius
      
      NSLayoutConstraint.activate([
         // sizes
         
         exitButton.heightAnchor.constraint(equalToConstant: buttonSize),
         exitButton.widthAnchor.constraint(equalToConstant: buttonSize),
         activitiesButton.heightAnchor.constraint(equalToConstant: buttonSize),
         activitiesButton.widthAnchor.constraint(equalToConstant: buttonSize),
         downloadButton.heightAnchor.constraint(equalToConstant: buttonSize),
         downloadButton.widthAnchor.constraint(equalToConstant: buttonSize),
         
         //
         
         exitButton.topAnchor.constraint(equalTo: topAnchor),
         exitButton.leadingAnchor.constraint(equalTo: leadingAnchor),
         activitiesButton.topAnchor.constraint(equalTo: topAnchor),
         activitiesButton.trailingAnchor.constraint(equalTo: downloadButton.leadingAnchor,
                                             constant: -8),
         downloadButton.topAnchor.constraint(equalTo: topAnchor),
         downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor)
      ])
      
      exitButton.layer.cornerRadius = cornerRadius
      activitiesButton.layer.cornerRadius = cornerRadius
      downloadButton.layer.cornerRadius = cornerRadius
   }
   
	var exitButton = UIButton(type: .system)
	var activitiesButton = UIButton(type: .system)
	var downloadButton = UIButton(type: .system)
	
	weak var delegate: TopControlBarDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	private func commonInit() {
		let exitImage = UIImage(systemName: "xmark")
		let activitiesImage = UIImage(systemName: "square.and.arrow.up")
		let downloadImage = UIImage(systemName: "square.and.arrow.down")
		
		exitButton.setImage(exitImage,
								  for: .normal)
		activitiesButton.setImage(activitiesImage,
										  for: .normal)
		downloadButton.setImage(downloadImage,
										for: .normal)

		addSubview(exitButton)
		addSubview(activitiesButton)
		addSubview(downloadButton)
		
		exitButton.translatesAutoresizingMaskIntoConstraints = false
		activitiesButton.translatesAutoresizingMaskIntoConstraints = false
		downloadButton.translatesAutoresizingMaskIntoConstraints = false
		
		let color = #colorLiteral(red: 0.2032880485, green: 0.2233175337, blue: 0.2400064766, alpha: 1)
		
		exitButton.backgroundColor = color
		activitiesButton.backgroundColor = color
		downloadButton.backgroundColor = color
		
		exitButton.tintColor = .white
		activitiesButton.tintColor = .white
		downloadButton.tintColor = .white
		
		exitButton.addTarget(self,
									action: #selector(exitTapped),
									for: .touchUpInside)
		activitiesButton.addTarget(self,
											action: #selector(activitiesTapped),
											for: .touchUpInside)
		downloadButton.addTarget(self,
										 action: #selector(downloadTapped),
										 for: .touchUpInside)
	}
	
	@objc private func exitTapped() { delegate?.exitTapped() }
	@objc private func activitiesTapped() { delegate?.activitiesTapped() }
	@objc private func downloadTapped() { delegate?.downloadTapped() }

}

