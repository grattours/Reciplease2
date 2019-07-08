//
//  DetailFavoriteViewController.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit
import SafariServices

class DetailFavoriteViewController: UIViewController {
    
    @IBOutlet var detailFavoriteView: UIView!
    @IBOutlet weak var detailFavoriteTableView: UITableView!
    @IBOutlet weak var detailFavoriteImageView: UIImageView!
    @IBOutlet weak var detailFavoriteRate: UILabel!
    @IBOutlet weak var detailFavoriteTime: UILabel!
    @IBOutlet weak var detailFavoriteNameLabel: UILabel!
    @IBOutlet weak var littleView: UIView!
    
    private let recipService = RecipeService()
    private var netYService = NetYService()
    
    var recipeList = [RecipeData]()// all favorite
    var recipSelected: RecipeData? // data one favorite
    var ingredientLinesSelected = [String]() // components from
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // source recipe
    @IBAction func getDirections(_ sender: Any) {
        let urlString = recipSelected?.source
        guard let url = URL(string: urlString ?? "") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    // delete favorite and go back previous controller
    @IBAction func favoriteButton(_ sender: Any) {
        rejectFromFavorite()
        navigationController?.popViewController(animated: true)
    }
     // let urlString = recipSelected?.source
    @IBAction func shareButton(_ sender: Any) {
        guard let url = recipSelected?.source else { return }
        let message = "if you are hungry, you will have to go shopping ..."
        let items: [Any] = [message, url]
        let activity = UIActivityViewController(activityItems: items , applicationActivities: nil )
        present(activity,animated: true, completion: nil)
    }
    
    // something to do in Viewdidload
    private func setup() {
        navigationItem.rightBarButtonItem?.tintColor = .green
        self.navigationItem.title = "🥑🌽  FAVORITE DETAIL  🌽🥑"
        detailFavoriteRate.text = recipSelected?.rate
        detailFavoriteTime.text = recipSelected?.time
        detailFavoriteNameLabel.text = recipSelected?.name
        ingredientLinesSelected = recipSelected?.ingredientsLines?.components(separatedBy: ",") ?? [" "]
        if let imageData = recipSelected?.image {
            detailFavoriteImageView.image = image(UIImage(data: imageData as Data)!, withSize: CGSize(width: 600, height: 250))
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.littleView.bounds
        gradientLayer.colors = [UIColor.green.cgColor, UIColor.gray.cgColor]
        self.littleView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    // delete current favorite with id
    func rejectFromFavorite() {
        guard let id = recipSelected?.id else {
            self.presentAlert(message: .errorIdNoValid)
            return }
        if !recipService.deleteRecipe(id) {
            self.presentAlert(message: .errorNoDelete)
        }
    }
    
    // virer ?
    func image( _ image:UIImage, withSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.automatic)
    }
    
}

// MARK: - table view detail recipe with  ingredientlines
extension DetailFavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientLinesSelected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailFavoriteTableView.dequeueReusableCell(withIdentifier: "detailFavoriteCell", for: indexPath)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Bradley Hand", size: 26)
        let ingredient = ingredientLinesSelected[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}
