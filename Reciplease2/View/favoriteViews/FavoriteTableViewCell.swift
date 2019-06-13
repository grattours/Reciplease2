//
//  FavoriteTableViewCell.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import UIKit

class favoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var favoriteDetailLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var littleBlackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var favoritesRecipes: Recipe! { // from Coredata
        didSet {
            favoriteLabel.text = favoritesRecipes.name
            ratingLabel.text = favoritesRecipes.rate
            timerLabel.text = favoritesRecipes.time
            favoriteDetailLabel.text = favoritesRecipes.ingredients
            if let imageData =  favoritesRecipes.image {
                favoriteImageView.image = image(UIImage(data: imageData as Data)!,withSize: CGSize(width: 300, height: 150))
            }
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.littleBlackView.bounds
            gradientLayer.colors = [UIColor.green.cgColor, UIColor.gray.cgColor]
            self.littleBlackView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func image( _ image:UIImage, withSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.automatic)
    }
}
