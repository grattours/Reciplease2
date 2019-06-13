//
//  ListFavoriteViewController.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class ListFavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoritesListTabview: UITableView!
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var favoritesRecipes: [Recipe]!
    private var recipeService = RecipeService()
    var recipFavoriteSelected: Recipe?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesRecipes = recipeService.all
        favoritesListTabview.reloadData()
        self.navigationItem.title = "🥕🍆  \(favoritesRecipes.count) FAVORITES  🍆🥕"
 //       self.activityIndicator.isHidden = true
    }
    
    // delete all favorite with confirmation
    @IBAction func cleanAllFavorites(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Confirmation", message: "You really want to do this ?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if !self.recipeService.deleteAllFavorite() {
                self.presentAlert(message: .errorNoDelete)
            }
            self.favoritesRecipes = []
            self.favoritesListTabview.reloadData()
            self.navigationItem.title = "🥕🍆  0 FAVORITES  🍆🥕"
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("bouton annuler")
        }
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
}

// tableView listFavorite
extension ListFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = favoritesRecipes?.count else { return 0 }
        print(favoritesRecipes.count)
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! favoriteTableViewCell
        
        // Configure the cell
        cell.favoritesRecipes = favoritesRecipes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.activityIndicator.isHidden = true
        recipFavoriteSelected = favoritesRecipes[indexPath.row]
        performSegue(withIdentifier: "segueToDetailFavorite", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Empty - no favorite !"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return favoritesRecipes.isEmpty ? 200 : 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailFavorite" {
            let detailFavoriteVC = segue.destination as! DetailFavoriteViewController
            detailFavoriteVC.recipSelected = recipFavoriteSelected
        }
    }
}  // extension
