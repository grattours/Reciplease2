//
//  RecipeTableViewCell.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var littleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var recipe: Infos! {
        didSet {
            likeLabel.text = recipe.rating.description + "k"
            timeLabel.text = recipe.totalTimeInSeconds.intToStringMnSec()
            nameLabel.text = recipe.recipeName
            ingredientsLabel.text = recipe.ingredients.joined(separator: " ")
            let urlImage = recipe.smallImageUrls[0]
            let urlImage2 = urlImage.replacingOccurrences(of: "=s90", with: "=s200")
            recipeImageView.downloaded(from: urlImage2)
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.littleView.bounds
            gradientLayer.colors = [UIColor.black.cgColor, UIColor.gray.cgColor]
            self.littleView.layer.insertSublayer(gradientLayer, at: 0)
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func image( _ image:UIImage, withSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.automatic)
    }
    
}
