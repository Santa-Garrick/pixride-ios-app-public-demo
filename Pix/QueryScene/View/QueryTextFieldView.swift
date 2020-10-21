//
//  QueryTextFieldView.swift
//  Pix
//
//  Created by Николай Красиков on 09.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


class QueryTextFieldView: UIView, DynamicLayoutReceiver {
   var dynamicLayout: DynamicLayout!

   private var textDidChangeAction: ((String) -> Void)?
   private var returnTappedAction: (() -> Void)?
   private let textField = SearchTextField()
   
   convenience init(textDidChangeAction: @escaping (String) -> Void,
                    returnTappedAction: @escaping () -> Void) {
      self.init()
      self.textDidChangeAction = textDidChangeAction
      self.returnTappedAction = returnTappedAction
      
      textField.backgroundColor = #colorLiteral(red: 0.765534699, green: 0.07613589615, blue: 0.1549489498, alpha: 1)
      textField.layer.cornerRadius = 16
      textField.addTarget(self,
                          action: #selector(textFieldDidChange),
                          for: .editingChanged)
      textField.addTarget(self,
                          action: #selector(returnPressed),
                          for: .editingDidEndOnExit)
      
      
      addSubview(textField)
      textField.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         textField.topAnchor.constraint(equalTo: topAnchor,
                                        constant: 0),
         textField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                            constant: 16),
         textField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                             constant: -16)
      ])
      
   }
   @objc private func returnPressed(_ sender: UITextField) {
      returnTappedAction?()
   }
   
   @objc private func textFieldDidChange(_ sender: UITextField) {
      textDidChangeAction?(sender.text ?? "")
   }
   
   func resetText() {
      textField.text = ""
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      setupDynamicLayout()
   }
   
   func setupDynamicLayout() {
      textField.font = dynamicLayout.font
      textField.heightAnchor.constraint(equalToConstant: dynamicLayout.searchTextFieldHeight).isActive = true
      
   }
}
