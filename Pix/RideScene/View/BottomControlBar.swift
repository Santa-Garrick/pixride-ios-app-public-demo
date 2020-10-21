//
//  BottomControlBar.swift
//  Pix
//
//  Created by Pro13 on 29.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


protocol BottomControlBarDelegate: class {
	func speedChanged(_ value: Double)
	func playTapped()
}

class BottomControlBar: UIView, DynamicLayoutReceiver {
   var dynamicLayout: DynamicLayout!
   
   func setupDynamicLayout() {
      let playImage = UIImage(systemName: "play.fill")
      
      playButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 7, bottom: 6, right: 5)
      playButton.imageView?.contentMode = .scaleAspectFit
      playButton.setImage(playImage,
                          for: .normal)
      
      textLabel.font = dynamicLayout.font
      let buttonSize = dynamicLayout.playButtonSize
      NSLayoutConstraint.activate([
         // size
         playButton.heightAnchor.constraint(equalToConstant: buttonSize),
         playButton.widthAnchor.constraint(equalToConstant: buttonSize),
         // position
         playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
         playButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                             constant: buttonSize * 0.4),
         
         textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
         textLabel.leadingAnchor.constraint(equalTo: playButton.trailingAnchor,
                                            constant: buttonSize * 0.4),
         
         slider.centerYAnchor.constraint(equalTo: centerYAnchor),
         slider.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor,
                                         constant: buttonSize * 0.4),
         slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -buttonSize * 0.7)

      ])
      
      playButton.layer.cornerRadius = buttonSize / 2
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      setupDynamicLayout()
   }
   
	
	let buttonSize: CGFloat = 36
	
	var playButton = UIButton(type: .system)
	var textLabel = UILabel()
	var slider = UISlider()
	
	weak var delegate: BottomControlBarDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	private func commonInit() {
		
		textLabel.text = "Speed"
		textLabel.font = UIFont(name: "Circe-Light", size: 18)
      textLabel.textColor = .white
      
      slider.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
      slider.minimumValue = 0.5
      slider.maximumValue = 2.0
      slider.value = 1
      let thumb = UIImage(named: "thumb")
      slider.setThumbImage(thumb, for: .normal)
      addSubview(playButton)
		addSubview(textLabel)
		addSubview(slider)
		
		playButton.translatesAutoresizingMaskIntoConstraints = false
		textLabel.translatesAutoresizingMaskIntoConstraints = false
		slider.translatesAutoresizingMaskIntoConstraints = false
		
		let color = #colorLiteral(red: 0.2818331122, green: 0.2978203595, blue: 0.3144780397, alpha: 1)
		
		playButton.backgroundColor = color
		
		
		playButton.tintColor = .white
		
	
		playButton.addTarget(self,
									action: #selector(playTapped),
									for: .touchUpInside)
		slider.addTarget(self,
							  action: #selector(speedChanged),
							  for: .valueChanged)
		
	}
	
	@objc private func playTapped() {
		delegate?.playTapped()
	}
	@objc private func speedChanged(_ sender: UISlider) {
		delegate?.speedChanged(Double(sender.value))
	}

}

