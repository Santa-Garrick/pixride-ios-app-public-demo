//
//  Prefetching.swift
//  Pix
//
//  Created by Pro13 on 13.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation
import Kingfisher


protocol ImagePrefetching {
	func prefetch(urls: [URL])
   func prefetch(urls: [URL], completion: @escaping (_ success: Bool) -> Void)
}
