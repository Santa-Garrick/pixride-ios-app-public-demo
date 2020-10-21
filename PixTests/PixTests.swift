//
//  PixTests.swift
//  PixTests
//
//  Created by Pro13 on 07.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import XCTest
@testable import Pix



class UIViewExtensionTests: XCTestCase {
	
	var superview: UIView!
	var view: UIView!
	
	private var size1: CGSize {
		CGSize(width: 50, height: 50)
	}
	
	private var size2: CGSize {
		CGSize(width: 30, height: 30)
	}
	override func setUp() {
		superview = UIView()
		view = UIView()
		superview.addSubview(view)
	}
	
	override func tearDown() {
		superview = nil
		view = nil
	}
	
	func testTranslatingToCenterZeroOriginEqualSizes() {
		superview.frame = CGRect(origin: .zero,
										 size: CGSize(width: 50,
														  height: 50))
		view.frame = CGRect(origin: CGPoint(x: 10,
														y: 10),
								  size: CGSize(width: 50,
													height: 50))
		let vector = view.translationVectorToCenterInSuperview()
		let transform = CGAffineTransform(translationX: vector.dx,
													 y: vector.dy)
		view.transform = transform

		XCTAssert(view.frame.origin == .zero)
	}
	
	func testTranslatingToCenterNonZeroOriginEqualSizes() {
		superview.frame = CGRect(origin: CGPoint(x: 10,
															  y: 10),
										 size: CGSize(width: 50,
														  height: 50))
		view.frame = CGRect(origin: CGPoint(x: 10,
														y: 10),
								  size: CGSize(width: 50,
													height: 50))
		let vector = view.translationVectorToCenterInSuperview()
		let transform = CGAffineTransform(translationX: vector.dx,
													 y: vector.dy)
		view.transform = transform

		XCTAssert(view.frame.origin == .zero)
	}
	
	func testTranslatingToCenterZeroOriginDifferentSizes() {
		superview.frame = CGRect(origin: .zero,
										 size: CGSize(width: 50,
														  height: 50))
		view.frame = CGRect(origin: .zero,
								  size: CGSize(width: 30,
													height: 30))
		let vector = view.translationVectorToCenterInSuperview()
		let transform = CGAffineTransform(translationX: vector.dx,
													 y: vector.dy)
		view.transform = transform

		XCTAssert(view.frame.origin.x == 10)
		XCTAssert(view.frame.origin.y == 10)

	}
	
	func testTranslatingToCenterZeroOriginSuperviewDifferentSizes() {
		superview.frame = CGRect(origin: .zero,
										 size: CGSize(width: 50,
														  height: 50))
		view.frame = CGRect(origin: CGPoint(x: 10,
														y: 10),
								  size: CGSize(width: 30,
													height: 30))
		let vector = view.translationVectorToCenterInSuperview()
		let transform = CGAffineTransform(translationX: vector.dx,
													 y: vector.dy)
		view.transform = transform

		XCTAssert(view.frame.origin.x == 10)
		XCTAssert(view.frame.origin.y == 10)

	}
	
	func testTranslatingToCenterNonZeroOriginsDifferentSizes() {
		superview.frame = CGRect(origin: CGPoint(x: 20,
															  y: 20),
										 size: CGSize(width: 50,
														  height: 50))
		view.frame = CGRect(origin: CGPoint(x: 10,
														y: 10),
								  size: CGSize(width: 30,
													height: 30))
		let vector = view.translationVectorToCenterInSuperview()
		let transform = CGAffineTransform(translationX: vector.dx,
													 y: vector.dy)
		view.transform = transform
		
		XCTAssert(view.frame.origin.x == 10)
		XCTAssert(view.frame.origin.y == 10)
		
	}
	
	func testAspectFitTransformationEqualsFramesZeroOrigin() {
		superview.frame = CGRect(origin: CGPoint(x: 0,
															  y: 0),
										 size: CGSize(width: 50,
														  height: 50))
		view.frame = CGRect(origin: CGPoint(x: 0,
														y: 0),
								  size: CGSize(width: 50,
													height: 50))

		view.transform = view.aspectFitToSuperviewTransformation()
		
		XCTAssert(view.frame.origin.x == 0)
		XCTAssert(view.frame.origin.y == 0)
		
	}
	
	func testAspectFitTransformationNonHeightsFramesZeroOrigin() {
		superview.frame = CGRect(origin: CGPoint(x: 0,
															  y: 0),
										 size: CGSize(width: 50,
														  height: 50))
		view.frame = CGRect(origin: CGPoint(x: 0,
														y: 0),
								  size: CGSize(width: 50,
													height: 30))

		view.transform = view.aspectFitToSuperviewTransformation()
		
		XCTAssert(view.frame.origin.x == 0)
		XCTAssert(view.frame.origin.y == 10)
		
	}
	func testAspectFitTransformationNonEqualsFramesZeroOrigin() {
		superview.frame = CGRect(origin: CGPoint(x: 0,
															  y: 0),
										 size: CGSize(width: 50,
														  height: 50))
		view.frame = CGRect(origin: CGPoint(x: 0,
														y: 0),
								  size: CGSize(width: 30,
													height: 50))

		view.transform = view.aspectFitToSuperviewTransformation()
		
		XCTAssert(view.frame.origin.x == 10)
		XCTAssert(view.frame.origin.y == 0)
		
	}
	func testAspectFitTransformationNonEqualsFramesEqualsRatioZeroOrigin() {
		superview.frame = CGRect(origin: CGPoint(x: 0,
															  y: 0),
										 size: CGSize(width: 50,
														  height: 50))
		view.frame = CGRect(origin: CGPoint(x: 0,
														y: 0),
								  size: CGSize(width: 30,
													height: 30))

		view.transform = view.aspectFitToSuperviewTransformation()
		
		XCTAssert(view.frame.origin.x == 0)
		XCTAssert(view.frame.origin.y == 0)
		
	}
	func testAspectFitTransformationEqualSizesNonZeroOrigin() {
		superview.frame = CGRect(origin: CGPoint(x: 20,
															  y: 20),
										 size: CGSize(width: 50,
														  height: 50))
		view.frame = CGRect(origin: CGPoint(x: 10,
														y: 10),
								  size: CGSize(width: 50,
													height: 50))

		view.transform = view.aspectFitToSuperviewTransformation()
		
		XCTAssert(view.frame.origin.x == 0)
		XCTAssert(view.frame.origin.y == 0)
		
	}
	func testAspectFitTransformationDiffSizesNonZeroOrigin() {
		superview.frame = CGRect(origin: CGPoint(x: 20,
															  y: 20),
										 size: CGSize(width: 30,
														  height: 50))
		view.frame = CGRect(origin: CGPoint(x: 10,
														y: 10),
								  size: CGSize(width: 20,
													height: 10))

		view.transform = view.aspectFitToSuperviewTransformation()
		
		XCTAssert(view.frame.origin.x == 0)
		XCTAssert(view.frame.origin.y == (50.0 - 15.0) / 2.0)
		
	}
	
	
	
}

/*


func translationVectorToCenterInSuperview() -> CGVector {
	
	let superViewCenterX = superview!.frame.size.width / 2
	let superViewCenterY = superview!.frame.size.height / 2
	
	return CGVector(dx: superViewCenterX - self.center.x,
						 dy: superViewCenterY - self.center.y)
}
*/

class PixTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
