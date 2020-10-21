//
//  RemoteImage.swift
//  Pix
//
//  Created by Pro13 on 13.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


protocol RemoteImage {
	var url: URL { get }
	var size: CGSize { get }
}

