//
//  OrientationAwareLayout.swift
//  Pix
//
//  Created by Николай Красиков on 21.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


class OrientationAwareLayout: DynamicLayout {
   var bottomBarRightInset: CGFloat {
      switch UIDevice.current.orientation {

      case .portrait, .portraitUpsideDown:
         return baseLayout.bottomBarRightInset
      case .landscapeLeft, .landscapeRight:
         return baseLayout.bottomBarRightInset + UIScreen.main.bounds.size.width / 2
      default:
         return baseLayout.bottomBarRightInset
      }
   }
   
   
   let baseLayout: DynamicLayout
   init(base: DynamicLayout) {
      self.baseLayout = base
   }
   
   var playButtonSize: CGFloat { return baseLayout.playButtonSize }
   
   var font: UIFont? { return baseLayout.font }
   
   var cellLabelInsets: CGFloat { return baseLayout.cellLabelInsets }
   
   var cellLabelHeight: CGFloat { return baseLayout.cellLabelHeight }
   
   var controlBarHeight: CGFloat { return baseLayout.controlBarHeight }
   
   var cornerRadius: CGFloat { return baseLayout.cornerRadius }
   
   var startButtonHeight: CGFloat { return baseLayout.startButtonHeight }
   
   var searchTextFieldHeight: CGFloat { return baseLayout.searchTextFieldHeight }
   
   var rideViewVerticalInset: CGFloat {
      switch UIDevice.current.orientation {

      case .portrait, .portraitUpsideDown:
         return baseLayout.rideViewVerticalInset + controlBarHeight
      case .landscapeLeft, .landscapeRight:
         return baseLayout.rideViewVerticalInset
      default:
         return baseLayout.rideViewVerticalInset
      }
      
   }
   
   func heightForRow(atIndexPath indexPath: IndexPath) -> CGFloat {
      return baseLayout.heightForRow(atIndexPath: indexPath)
   }
   
   var heightForSearchFieldFooter: CGFloat { return baseLayout.heightForSearchFieldFooter }
   
   var heightForHeader: CGFloat { return baseLayout.heightForHeader }

}
