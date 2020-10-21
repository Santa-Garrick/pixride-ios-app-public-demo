//
//  SwinjectStoryboard+Extension.swift
//  Pix
//
//  Created by Николай Красиков on 09.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
   
   static var useFakeServices = false
   
   @objc class func setup() {
      if useFakeServices {
         setupFakeServices()
      } else {
         setupServices()
      }
      setupQueryScene()
      setupRideScene()
   }
   
   class func setupQueryScene() {
      defaultContainer.register(QueryPresenting.self) { r in
         let fetcher = r ~> CategoriesFetching.self
         return QueryPresenter(withFetcher: fetcher)
      }.inObjectScope(.container)
      
      defaultContainer.register(RideQuery.self) { r in
         let presenter = r ~> QueryPresenting.self
         return presenter.query
      }
      defaultContainer
         .storyboardInitCompleted(QueryViewController.self) { r, vc in
            var presenter = r ~> QueryPresenting.self
            presenter.view = vc
            vc.presenter = presenter
            vc.dynamicLayout = r ~> DynamicLayout.self
         }
   }
   class func setupRideScene() {
      defaultContainer.autoregister(RideModelProtocol.self, initializer: RideModel.init)
      defaultContainer
         .storyboardInitCompleted(RideViewController.self) { r, vc in
            
            var model = r ~> RideModelProtocol.self
            model.delegate = vc
            vc.model = model
            vc.dynamicLayout = r ~> DynamicLayout.self
         }
   }
   class func setupFakeServices() {
      defaultContainer.register(Searching.self) { _ in
         let searcher = PixabaySearcherWithFakeDelay()
         searcher.isFakingWorstCase = false
         return searcher
      }
      defaultContainer.autoregister(RemoteImageProvider.self,
                                    initializer: KFImageProvider.init)
      defaultContainer.autoregister(ImagePrefetching.self,
                                    initializer: KFImagePrefetcher.init)
      
      defaultContainer.register(CategoriesFetching.self) { r in
         
         let fetcher = CategoriesFetcher()
         fetcher.networkFetcher = FakeNetworkCategoriesFetcher(delayRange: 0.5..<5)
         fetcher.defaults = PlistDefaultCategoriesLoader()
         return fetcher
      }
   }
   
   class func setupServices() {
      
      defaultContainer.autoregister(Searching.self,
                                    initializer: PixabaySearcher.init)
      defaultContainer.autoregister(RemoteImageProvider.self,
                                    initializer: KFImageProvider.init)
      defaultContainer.autoregister(ImagePrefetching.self,
                                    initializer: KFImagePrefetcher.init)
      defaultContainer.register(DynamicLayout.self) { r in
         let deviceAware = DeviceAwareLayout()
         return OrientationAwareLayout(base: deviceAware)
      }
      defaultContainer.register(CategoriesFetching.self) { r in
         
         let fetcher = CategoriesFetcher()
         fetcher.networkFetcher = NetworkCategoriesFetcher()
         fetcher.defaults = PlistDefaultCategoriesLoader()
         return fetcher
      }
   }
}
