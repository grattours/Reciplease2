//
//  DetailRecipeViewController.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit
import SafariServices

class DetailRecipeViewController: UIViewController {
    
    private let recipService = RecipeService()
    
    @IBOutlet var detailRecipeView: UIView!
    @IBOutlet weak var recipeDetailsTableView: UITableView!
    @IBOutlet weak var recipeDetailNameLabel: UILabel!
    @IBOutlet weak var recipeDetailImageView: UIImageView!
    @IBOutlet weak var recipeDetailRatingLabel: UILabel!
    @IBOutlet weak var recipeDetailTimeLabel: UILabel!
    @IBOutlet weak var littleView: UIView!
    
    var recipeDetailList = [RecipeDetail]()
    var listOfIngredient: [String]!
    var recipeDetail: RecipeDetail!
    var recipe: Infos?
    var isFavorite: Bool { return recipService.checkIfRecipeIsFavorite(id: recipeDetailList[0].id) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
        if navigationItem.rightBarButtonItem?.tintColor == .white {
            navigationItem.rightBarButtonItem?.tintColor = .green
            keepInFavorite()
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .white
            rejectFromFavorite()
        }
    }
    
    @IBAction func getDirections(_ sender: Any) {
        if let urlString = recipeDetailList[0].source.sourceRecipeUrl {
            directionSafari(for: urlString)
        } else {
            self.presentAlert(message: .errorNoSource)
        }
    }
    
    // what to do when View is loaded
    private func setup() {
        navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationItem.title = "🥕🍆  RECIPE DETAIL  🍆🥕"
        if isFavorite {
            navigationItem.rightBarButtonItem?.tintColor = .green
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .white
        }
        recipeDetail = recipeDetailList[0]
        recipeDetailNameLabel.text = recipeDetailList[0].name
        let time = recipeDetailList[0].totalTimeInSeconds
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        recipeDetailTimeLabel.text = String(format: "%01i:%02i", hours, minutes)
        recipeDetailRatingLabel.text = String(recipeDetailList[0].rating) + "k"
        guard let urlImage = recipeDetailList[0].images[0]?.hostedLargeUrl else { return }
        recipeDetailImageView.downloaded(from: urlImage)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.littleView.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.gray.cgColor]
        self.littleView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // save favorite
    func keepInFavorite() {
        if !isFavorite {
            guard let ingredientsString = recipe?.ingredients.joined(separator: ",") else { return }
            recipService.saveRecipe(recipeDetail, ingredientsString)
        } else {
            self.presentAlert(message: .errorAlwayFavorite)
        }
    }
    
    // delete favorite
    func rejectFromFavorite() {
        if !recipService.deleteRecipe(recipeDetail.id) {
            self.presentAlert(message: .errorNoDelete)
        }
    }
    
    // go to source recipe
    private func directionSafari(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
}

// TableView Recipe ingredients
extension DetailRecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetailList[0].ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeDetailsTableView.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath)
        let ingredient = recipeDetailList[0].ingredientLines[indexPath.row]
        cell.textLabel?.text = ingredient
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Bradley Hand", size: 26)
        return cell
    }
}
