//
//  QueryViewController.swift
//  Pix
//
//  Created by Pro13 on 08.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


class QueryViewController: LoadingViewController, DynamicLayoutReceiver {
   
   var dynamicLayout: DynamicLayout!
   
   var presenter: QueryPresenting!
   let observer = KeyboardHeightObserver()
   var categories: [String] = []
   
   let segueID = "GoToRide"
   let cellID = "CategoryCell"
   
   // constraints
   @IBOutlet weak var tableCenterYConstraint: NSLayoutConstraint!
   @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
   @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
   
   // ui elements
   @IBOutlet weak var startRideButton: UIButton!
   @IBOutlet weak var categoriesTableView: UITableView!
   
   lazy var headerView: UIView = HeaderView()
   lazy var textFieldView: QueryTextFieldView = {
      let view = QueryTextFieldView(textDidChangeAction: self.textDidChange,
                                    returnTappedAction: self.returnPressed)
      view.dynamicLayout = self.dynamicLayout
      return view
   }()
   
   override func startActivityAnimation() {
      super.startActivityAnimation()
      _ = [startRideButton, categoriesTableView].map { $0?.isHidden = true }
   }
   
   override func stopActivityAnimation() {
      super.stopActivityAnimation()
      _ = [startRideButton, categoriesTableView].map { $0?.isHidden = false }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      activityAnimationDelay = 0.5
      setupActivityIndicator()
      
      startActivityAnimation()
      
      dismissKeyboardOnTouchOutside()
      
      setupTableView()
      setupStartButton()
      
      observer.delegate = self
      
      presenter.getCategories()
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      setupDynamicLayout()
      tableHeightConstraint.constant = categoriesTableView.contentSize.height
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      OrientationLocker.lockOrientation(.portrait)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      OrientationLocker.lockOrientation(.all)
   }
   
   
   func setupDynamicLayout() {
      buttonHeightConstraint.constant = dynamicLayout.startButtonHeight
      startRideButton.titleLabel?.font = dynamicLayout.font
   }
}


// MARK: - Actions
extension QueryViewController {
   @IBAction func rideTapped(_ sender: UIButton) {
      performSegue(withIdentifier: segueID,
                   sender: self)
   }
   func returnPressed() {
      performSegue(withIdentifier: segueID,
                   sender: self)
   }
   func textDidChange(_ text: String) {
      presenter.setCustomQuery(text)
   }
}
