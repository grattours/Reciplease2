//
//  SearchRecipeViewController.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class SearchRecipeViewController: UIViewController {
    
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var netYService = NetYService()

    
    var ingredientsList : [String] = []
    var recipeList = [Infos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicatorView.isHidden = true
    }
    
    // add ingredient to the list
    @IBAction func addlIngredientsButton() {
        guard let inputString = ingredientsTextField.text, inputString.count > 0 else {
            self.presentAlert(message: .errorIngredientneeded)
            return }
        var cleanString = inputString.lowercased()
        cleanString = cleanString.trimmingCharacters(in: .whitespacesAndNewlines)
        ingredientsList = cleanString.components(separatedBy: " ")
        ingredientsTableView.reloadData()
    }
    
    // clear input field
    @IBAction func clearIngredients(_ sender: UIButton) {
        ingredientsList = []
        ingredientsTextField.text = ""
        ingredientsTableView.reloadData()
    }
    
    // search recipers
    @IBAction func searchRecipes(_ sender: Any) {
        if ingredientsList != [] {
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
            setupRecipesListData(ingredientsList)
        } else {
            self.presentAlert(message: .errorIngredientneeded)
        }
    }
    
    // from ViewDidload
    private func setup() {
        self.navigationItem.title = "🍽 🌽🍅 RECIPLEASE 🥦🥕 🍽"
        guard let tabBar = self.tabBarController?.tabBar else { return }
        tabBar.tintColor = UIColor.green
        tabBar.barTintColor = UIColor.black
        tabBar.unselectedItemTintColor = UIColor.white
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
        ingredientsTableView.reloadData()
    }
    
    // MARK: - search data from the API with ingredient
    private func setupRecipesListData(_ ingredientsList: [String]) {
        netYService.getRecipes(ingredientsList) { (success, recipeStruc, error) in
            guard let nb = recipeStruc?.matches.count else {
                return }
            
            if success, nb > 0 {
                guard let recipeStruc = recipeStruc else { return }
                self.recipeList = recipeStruc.matches
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "segueToRecipList", sender: self)
                    self.activityIndicatorView.stopAnimating()
                }
            } else {
                self.presentAlert(message: .errorRecipeLoaded)
                self.activityIndicatorView.isHidden = true
                self.activityIndicatorView.stopAnimating()
            }
        }
        
    }
    
    // prepare transition to listControlleur
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipList" {
            guard let reciplistVC = segue.destination as? ListRecipeViewController else {return}
            reciplistVC.recipsList = recipeList
        }
    }
    
}

// MARK: - delegate tableView ingredients
extension SearchRecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = ingredientsList[indexPath.row]
        let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = ingredient
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Bradley Hand", size: 26)
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Modify", handler: { (action, indexPath) in
            let alert = UIAlertController(title: "", message: "Modify an ingredient", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                self.ingredientsTextField.text = self.ingredientsList[indexPath.row]
            })
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                self.ingredientsList[indexPath.row] = (alert.textFields?.first!.text!)!
                self.ingredientsTableView.reloadRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        })
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.ingredientsList.remove(at: indexPath.row)
            tableView.reloadData()
        })
        
        return [deleteAction, editAction]
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            ingredientsList.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}

// hidde keyboard when return
extension SearchRecipeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredientsTextField.resignFirstResponder()
        return true
    }
}

