//
//  RecipeTableViewCell..swift
//  Reciplease-OC-P10
//
//  Created by Luc Derosne on 26/05/2019.
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
            // faire une fonction
            print("RecipTableViewCell didSet")
            let time = recipe.totalTimeInSeconds
            let hours = Int(time) / 3600
            let minutes = Int(time) / 60 % 60
            timeLabel.text = String(format: "%01i:%02i", hours, minutes)
            nameLabel.text = recipe.recipeName
            ingredientsLabel.text = recipe.ingredients.joined(separator: " ")
            //recipeImageView.image = UIImage(named: "chef")
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
        littleView.backgroundColor = UIColor.black
    }
    
}
