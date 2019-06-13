//
//  RecipeService.swift
//  
//
//  Created by Luc Derosne on 12/06/2019.
//
import Foundation
import Alamofire
import CoreData

//import AlamofireImage

class RecipeService {
    
    //    var managedObjectContext: NSManagedObjectContext!
    let ApiKeyRequest = valueForAPIKey(named:"API_Key_Yummly")
    let ApiIdRequest = valueForAPIKey(named:"API_Id_Yummly")
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init() {
        self.managedObjectContext = AppDelegate.coreDataStack.mainContext
        self.coreDataStack = AppDelegate.coreDataStack
    }
    
    var all: [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let recipes = try? managedObjectContext.fetch(request) else {return []}
        return recipes
    }
    
    // compose url with ingredients list
    func createRecipeRequest(_ list:String) -> String {
        let OptionsRequest = "requirePictures=true"
        let  URLString = "https://api.yummly.com/v1/api/recipes?_app_id=\(ApiIdRequest)&_app_key=\(ApiKeyRequest)&q=\(list)&\(OptionsRequest)"
        return URLString
    }
    
    // save recipe as favorite in recipe Detail list
    func saveRecipe(_ recipeToSave: RecipeDetail, _ ingredientsString: String) {
        // context creation
        let recipeSave = Recipe(context: managedObjectContext)
        // context implementation
        recipeSave.id = recipeToSave.id
        recipeSave.ingredientsLines = recipeToSave.ingredientLines.joined(separator: ",")
        recipeSave.ingredients = ingredientsString
        //recipeSave.ingredients = recipeToSave.ingredientLines.joined(separator: ",") // changer
        recipeSave.name = recipeToSave.name
        let time = recipeToSave.totalTimeInSeconds
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        recipeSave.time = String(format: "%01i:%02i", hours, minutes) // plus qu'a afficher
        recipeSave.rate = recipeToSave.rating.description + "k"
        recipeSave.source = recipeToSave.source.sourceRecipeUrl?.description ?? "https://www.yummly.com/"
        guard let urlImage = recipeToSave.images[0].hostedLargeUrl else { return }
        recipeSave.image = urlImage.absoluteString.urlImagetoDataImage as NSData? as Data?
        // context save
        coreDataStack.saveContext(managedObjectContext)
    }
    
    // delete recipe favori from Core Data with id
    func deleteRecipe(_ id: String) -> Bool {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        guard let recipe = try? managedObjectContext.fetch(request), recipe.count > 0 else {
            print("error delete recipe")
            return false
        }
        managedObjectContext.delete(recipe[0])
        coreDataStack.saveContext(managedObjectContext)
        return true
    }
    
    // delete all favorite in CoreData from favorite list
    func deleteAllFavorite() -> Bool {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
        } catch {
            print("error cleaning favorites")
            return false
        }
        
        return true
    }
    
    // search data with endpoint and ingredient list
    func getRecipes(_ ingredientsList:[String], callback: @escaping(Bool, RecipeStruc?) -> Void) {
        var list = ""
        for ingredient in ingredientsList {
            list +=  ingredient + "+"
        }
        list = String(list.dropLast())
        guard let url = URL(string: createRecipeRequest(list)) else { return }
        Alamofire.request(url).responseJSON { (response) in
            guard response.result.isSuccess,
                let data = response.data else {
                    callback(false, nil)
                    return
            }
            guard let responseJson = try? JSONDecoder().decode(RecipeStruc.self, from: data) else {
                callback(false, nil)
                return
            }
            callback(true, responseJson)
        }
    }
    
    // compose url with id of the choosen recipe
    func createRecipeDetailRequest(id: String) -> String {
        let  URLString = "https://api.yummly.com/v1/api/recipe/\(id)?_app_id=\(ApiIdRequest)&_app_key=\(ApiKeyRequest)"
        return URLString
    }
    
    func getFavoriteDetails(id: String) {
        print(" est ce bien nécessaire ?")
    }
    
    // search data with endpoint and id
    func getRecipDetail(id: String, callback: @escaping(Bool, RecipeDetail?) -> Void) {
        print("getRecipDetail")
        guard let url = URL(string: createRecipeDetailRequest(id: id)) else {
            print("error url getRecipDetail")
            return }
        Alamofire.request(url).responseJSON { (response) in
            guard response.response?.statusCode == 200 else {
                print("reponse error code <> 200")
                return
            }
            guard response.result.isSuccess,
                let data = response.data else {
                    callback(false, nil)
                    print("data error detail")
                    return
            }
            guard let responseJson = try? JSONDecoder().decode(RecipeDetail.self, from: data) else {
                print("response json error detail")
                callback(false, nil)
                return
            }
            callback(true, responseJson)
            
        }
    }
    
    // is recipe already favorite ?
    func checkIfRecipeIsFavorite(id: String) -> Bool {
        var count = 0
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        do {
            count = try managedObjectContext.count(for: request)
        } catch let erreur {
            print(erreur)
        }
        return count > 0
    }
    
} // class

