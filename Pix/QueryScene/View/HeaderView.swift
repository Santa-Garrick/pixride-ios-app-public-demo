//
//  HeaderView.swift
//  Pix
//
//  Created by Николай Красиков on 08.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


class HeaderView: UIView {
   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = #colorLiteral(red: 1, green: 0.1058823529, blue: 0.2078431373, alpha: 1)

      let label = UILabel()
      label.text = "CHOOSE WHAT TO RIDE"
      label.textAlignment = .center
      label.font = UIFont(name: "Circe-Regular", size: 12)
      label.textColor = .black
      
      addSubview(label)
      label.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
         label.topAnchor.constraint(equalTo: topAnchor,
                                    constant: 16),
         label.centerXAnchor.constraint(equalTo: centerXAnchor),
         label.heightAnchor.constraint(equalToConstant: 18)
      ])
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
