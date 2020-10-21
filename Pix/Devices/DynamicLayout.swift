//
//  DynamicLayout.swift
//  Pix
//
//  Created by Николай Красиков on 21.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


protocol DynamicLayout {
   
   var font: UIFont? { get }
   var cellLabelInsets: CGFloat { get }
   var cellLabelHeight: CGFloat { get }
   var controlBarHeight: CGFloat { get }
   
   var cornerRadius: CGFloat { get }
   var startButtonHeight: CGFloat { get }
   var searchTextFieldHeight: CGFloat { get }
   var playButtonSize: CGFloat { get }
   var bottomBarRightInset: CGFloat { get }
   var rideViewVerticalInset: CGFloat { get }
   
   func heightForRow(atIndexPath indexPath: IndexPath) -> CGFloat
   
   var heightForSearchFieldFooter: CGFloat { get }
   var heightForHeader: CGFloat { get }

}
