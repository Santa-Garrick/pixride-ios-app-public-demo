//
//  Rider.swift
//  Pix
//
//  Created by Pro13 on 12.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation


class Rider {
	
	private var timer: Timer?
	weak var view: RideView?
	var shouldSkipEmpty: Bool = false
	private(set) var isRiding: Bool = false
	
	var speed: Double = 1
	
	func start() {
		restart()
		isRiding = true
	}
	
	func stop() {
		timer?.invalidate()
		isRiding = false
	}
	
	private func restart() {
		timer?.invalidate()
		
		guard speed != 0 else { return }
		
		let timeInterval = 1.0 / abs(speed)
		timer = Timer.scheduledTimer(timeInterval: timeInterval,
											  target: self,
											  selector: #selector(move),
											  userInfo: nil,
											  repeats: true)
	}
	
	@objc private func move() {
		if speed > 0 {
         view?.showNext(shouldSkipEmpty: shouldSkipEmpty, animated: true)
		}
		if speed < 0 {
         view?.showPrevious(shouldSkipEmpty: shouldSkipEmpty, animated: true)
		}
	}
}
