//
//  ListRecipeViewController.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//


import UIKit

class ListRecipeViewController: UIViewController {
    
    @IBOutlet weak var recipsTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // private let recipeService = RecipeService()
    private let netYService = NetYService()
    
    var recipsList = [Infos]()
    var recipeDetailList = [RecipeDetail]()
    var recipe: Infos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.tintColor = .white
        recipsTableView.reloadData()
        recipsTableView.tableFooterView = UIView()
        self.navigationItem.title = "🍽 👩🏼‍🍳  \(recipsList.count) RECIPES  👨🏼‍🍳 🍽"
        activityIndicatorView.isHidden = true
        recipsTableView.reloadData()
    }
    
}

//  delegate tableView recipes list
extension ListRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {  // gérer l'alerte ? (enum/extension)
        guard indexPath.item < recipsList.count else { fatalError("index out of range")}
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.recipe = recipsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        recipe = self.recipsList[indexPath.row]
        let id = self.recipsList[indexPath.row].id
        getRecipsDetail(id: id)
    }
    
    private func getRecipsDetail(id: String) {
        netYService.getRecipDetail(id: id) { (success, recipDetailData, error) in
            if success {
                guard let recipeDetail = recipDetailData else { return }
                self.recipeDetailList = [recipeDetail]
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "segueToDetail", sender: self)
                    // self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.isHidden = true
                }
            } else {
                self.presentAlert(message: .errorNoSource)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail" {
            let detailVC = segue.destination as! DetailRecipeViewController
            detailVC.recipeDetailList = recipeDetailList
            detailVC.recipe = recipe
        }
    }
}  // extension List
