//
//  DeviceAwareLayout.swift
//  Pix
//
//  Created by Николай Красиков on 14.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


class DeviceAwareLayout: DynamicLayout {
   var bottomBarRightInset: CGFloat {
      
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return 16
      default:
         return 24
      }
      
   }
   var playButtonSize: CGFloat {
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return 28
      default:
         return 36
      }
   }
   
   var rideViewVerticalInset: CGFloat {
      
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return 16
      default:
         return 24
      }
      
   }
   
   var cornerRadius: CGFloat {
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return 16
      default:
         return 24
      }
   }
   
   var controlBarHeight: CGFloat {
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return 48
      default:
         return 64
      }
   }
   
   
   var font: UIFont? {
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return UIFont(name: "Circe-Regular", size: 18)
      default:
         return UIFont(name: "Circe-Regular", size: 22)
      }
   }
   
   var cellLabelInsets: CGFloat {
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return 6.5
      default:
         return 8
      }
   }
   
   var cellLabelHeight: CGFloat {
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return 27
      default:
         return 32
      }
   }
   
   var startButtonHeight: CGFloat {
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return 48
      default:
         return 64
      }
   }
   
   var searchTextFieldHeight: CGFloat {
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return 40
      default:
         return 48
      }
   }
   
   func heightForRow(atIndexPath indexPath: IndexPath) -> CGFloat {
      switch UIDevice().type {
      
      case .iPhone6, .iPhone6S, .iPhoneSE:
         return 40
      case .iPhone11ProMax, .iPhone11Pro:
         return indexPath.row == 0 ? 59 : 48
      default:
         return 48
      }
   }
   
   var heightForSearchFieldFooter: CGFloat{
      return searchTextFieldHeight + 16
   }
   
   var heightForHeader: CGFloat{
      return 48
   }
}

