//
//  RideViewController+TopControlBarDelegate.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension RideViewController: TopControlBarDelegate {
   func exitTapped() {
      dismiss(animated: true, completion: nil)
   }
   
   func activitiesTapped() {
      let index = rideView.topIndex
      model.getUIImage(for: index) { [weak self] (result) in
         switch result {
         
         case .success(let image):
            self?.presentActivityVC(forImage: image)
         case .failure(let error):
            print(error)
         }
      }
   }
   func downloadTapped() {
      let index = rideView.topIndex
      model.getUIImage(for: index) { [weak self] (result) in
         switch result {
         
         case .success(let image):
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           #selector(self?.savingDidFinish),
                                           nil)
         case .failure(let error):
            print(error)
         }
      }
      
   }
   @objc private func savingDidFinish(_ image: UIImage,
                                      didFinishSavingWithError error: Error?,
                                      contextInfo: UnsafeRawPointer) {
      if let error = error {
         let ac = UIAlertController(title: "Saving error",
                                    message: error.localizedDescription,
                                    preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "OK", style: .default))
         present(ac, animated: true)
      } else {
         let ac = UIAlertController(title: "Saved",
                                    message: "",
                                    preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "OK", style: .default))
         present(ac, animated: true)
      }
      
   }
}
