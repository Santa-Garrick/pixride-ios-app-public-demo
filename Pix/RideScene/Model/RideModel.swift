//
//  RideModel.swift
//  Pix
//
//  Created by Николай Красиков on 16.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


protocol RideModelProtocol {
   
   var imagesCount: Int { get }
   var delegate: RideModelDelegate? { get set }
   subscript(index: Int) -> UIImageView { get }
   func getUIImage(for index: Int,
                   completion: @escaping (Result<UIImage, Error>) -> Void)
   func prefetch(atIndex index: Int)
   func fetchNewRemotes()
}

protocol RideModelDelegate: class {
   func modelDidUpdate()
}

class RideModel: RideModelProtocol {
   
   var searcher: Searching
   var imageProvider: RemoteImageProvider
   var prefetcher: ImagePrefetching
   weak var delegate: RideModelDelegate?
   
   private(set) var remoteImages: [RemoteImage] = []
   
   var imagesCount: Int {
      return remoteImages.count
   }
   
   init(query: RideQuery,
        searcher: Searching,
        imageProvider: RemoteImageProvider,
        prefetcher: ImagePrefetching) {
      
      self.searcher = searcher
      self.imageProvider = imageProvider
      self.prefetcher = prefetcher
      searcher.setQuery(query: query)
   }
   
   
   subscript(index: Int) -> UIImageView {
      imageProvider.makeImageView(withRemoteImage: remoteImages[index])
   }
   
   func prefetch(atIndex index: Int) {
      let url = remoteImages[index].url
      prefetcher.prefetch(urls: [url])
   }
   func fetchNewRemotes() {
      searcher.fetchNext { [weak self] (result) in
         switch result {

         case .success(let remotes):
            self?.handleFetchedRemotes(remotes)
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func handleFetchedRemotes(_ remotes: [RemoteImage]) {
      remoteImages.append(contentsOf: remotes)
      let urls = remotes.map {$0.url}
      self.prefetcher.prefetch(urls: urls) { [weak self] (success) in

         if success {
            self?.delegate?.modelDidUpdate()
         } else {
            self?.fetchNewRemotes()
         }
      }
   }
   
   func getUIImage(for index: Int,
                   completion: @escaping (Result<UIImage, Error>) -> Void) {
      let url = remoteImages[index].url
      imageProvider.getImage(for: url, completion: completion)
   }
   
}

