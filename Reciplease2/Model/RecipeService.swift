//
//  RecipeService.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class RecipeService {
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack

    init() {
        self.managedObjectContext = AppDelegate.coreDataStack.mainContext
        self.coreDataStack = AppDelegate.coreDataStack
    }
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    var all: [RecipeData] {
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        guard let recipes = try? managedObjectContext.fetch(request) else {return []}
        return recipes
    }
    
    // save recipe as favorite in recipe Detail list
    func saveRecipe(_ recipeToSave: RecipeDetail, _ ingredientsString: String) {
        // context creation
        let recipeSave = RecipeData(context: managedObjectContext)
        // context implementation
        recipeSave.id = recipeToSave.id
        recipeSave.ingredientsLines = recipeToSave.ingredientLines.joined(separator: ",")
        recipeSave.ingredients = ingredientsString
        recipeSave.name = recipeToSave.name
        recipeSave.time = recipeToSave.totalTimeInSeconds.intToStringMnSec()
        recipeSave.rate = recipeToSave.rating.description + "k"
        recipeSave.source = recipeToSave.source.sourceRecipeUrl?.description ?? "https://www.yummly.com/"
        guard let urlImage = recipeToSave.images[0]?.hostedLargeUrl else { return }
        recipeSave.image = urlImage.absoluteString.urlImagetoDataImage as NSData? as Data?
        // context save
        coreDataStack.saveContext(managedObjectContext)
    }
    
    // delete recipe favori from Core Data with id
    func deleteRecipe(_ id: String) -> Bool {
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        guard let recipe = try? managedObjectContext.fetch(request), recipe.count > 0 else {
            return false
        }
        managedObjectContext.delete(recipe[0])
        coreDataStack.saveContext(managedObjectContext)
        return true
    }
    
    // delete all favorite in CoreData from favorite list
    func deleteAllFavorite() -> Bool {
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
        } catch {
            return false
        }
        
        return true
    }
    
    // is recipe already favorite ?
    func checkIfRecipeIsFavorite(id: String) -> Bool {
        var count = 0
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        do {
            count = try managedObjectContext.count(for: request)
        } catch  {
            return false
        }
        return count > 0
    }
    
} // class

