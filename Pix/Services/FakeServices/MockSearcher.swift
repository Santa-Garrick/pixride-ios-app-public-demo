//
//  MockSearcher.swift
//  Pix
//
//  Created by Pro13 on 13.09.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit
import Kingfisher

/*
"https://pixabay.com/get/54e0dd404e5bae14f6da8c7dda7936761737dfe35b556c48702672dd9e4cc258b9_1280.jpg"

"https://pixabay.com/get/51e3d34b4d55b108f5d0846096293f7c1d3ed8ed574c704c7c2672dd964ac559_1280.jpg"

"https://pixabay.com/get/57e2dd464c51a814f6da8c7dda7936761737dfe35b556c48702672dd9e4cc258b9_1280.png"

"https://pixabay.com/get/53e5d4464f56b108f5d0846096293f7c1d3ed8ed574c704c7c2672dd964ac559_1280.jpg"

"https://pixabay.com/get/50e9d1444952b108f5d0846096293f7c1d3ed8ed574c704c7c2672dd964ac559_1280.jpg"

"https://pixabay.com/get/55e2d6414c50b108f5d0846096293f7c1d3ed8ed574c704c7c2672dd964ac559_1280.jpg"

"https://pixabay.com/get/57e1d1444250b108f5d0846096293f7c1d3ed8ed574c704c7c2672dd964ac559_1280.jpg"

"https://pixabay.com/get/57e0d1464d5aae14f6da8c7dda7936761737dfe35b556c48702672dd9e4cc258b9_1280.jpg"

*/



struct MockRemoteImage: RemoteImage {
	let url: URL
	let size: CGSize
	
	
	static var mockData: [RemoteImage] {
		return [
		
			PixabayResponseImage(largeImageURL: "https://pixabay.com/get/54e0dd404e5bae14f6da8c7dda7936761737dfe35b556c48702672dd9e4fc45fbb_1280.jpg",
										imageWidth: 4928.0,
										imageHeight: 3008.0)
		]
	}
}

class MockSearcher: Searching {
	func setQuery(query: RideQuery) {
		//
	}
	
	func fetchNext(completion: @escaping (Result<[RemoteImage], Error>) -> Void) {
		sleep(1)
		let remotes: [RemoteImage] = MockRemoteImage.mockData
		completion(.success(remotes))
	}
	
	func reset() {
		//
	}
	
	
}
