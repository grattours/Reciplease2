//
//  Extensions.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import UIKit

// use case example : recipeSave.time = recipeToSave.totalTimeInSeconds.intToStringMnSec()
extension Int {
    func intToStringMnSec() -> String {
        //let time = recipeToSave.totalTimeInSeconds
        let hours : Int = self / 3600
        let minutes : Int = (self / 60) % 60
        let timeString = String(format: "%01i:%02i", hours, minutes)
        return timeString
    }
    
}

extension UIViewController {
    // use case example : self.presentAlert(message: .errorIngredientneeded)
    func presentAlert(message: errorMessage) {
        let alertVC = UIAlertController(title: "Alerte", message: message.rawValue, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}

// use case example : recipeDetailImageView.downloaded(from: urlImage)
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    
}
// use case example : recipeSave.image = urlImage.absoluteString.urlImagetoDataImage as NSData? as Data?
extension String {
    var urlImagetoDataImage: Data? {
        get {
            if let imageURL = URL(string: self) {
                let imageData = try? Data(contentsOf: imageURL)
                return imageData
            } else {
                return nil
            }
        }
    }
}
