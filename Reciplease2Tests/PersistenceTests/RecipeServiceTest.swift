//
//  RecipeServiceTest.swift
//  Reciplease2Tests
//
//  Created by Luc Derosne on 14/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//


import Foundation
import CoreData
import XCTest
@testable import Reciplease2

class RecipeServiceTest: XCTestCase {
    
    var recipeService: RecipeService!
    var coreDataStack: CoreDataStack!
    
    private let recipeExample3 = RecipeDetail(id: "03", name: "Saumon Wasabi", ingredientLines: ["Saumon 250 gr", "Wasabi un peu"], totalTimeInSeconds: 150, rating: 5, images: [Image.init(hostedLargeUrl: URL(string: "urlimage3"))], source: Source.init(sourceRecipeUrl: "UrlTest3"))
    
    private let recipeExample4 = RecipeDetail(id: "04", name: "Lapin à la moutarde", ingredientLines: ["Lapin 4 kg", "Moutarde un max"], totalTimeInSeconds: 350, rating: 3, images: [Image.init(hostedLargeUrl: URL(string: "urlimage4"))], source: Source.init(sourceRecipeUrl: "UrlTest4"))
    
    override func setUp() {
        super.setUp()
        
        coreDataStack = TestCoreDataStack()
        recipeService = RecipeService(
            managedObjectContext: coreDataStack.mainContext,
            coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        deleteAllDetailedRecipeDataTests()
        coreDataStack = nil
        recipeService = nil
    }
    
    private func deleteAllDetailedRecipeDataTests() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
        _ = try? coreDataStack.mainContext.execute(deleteRequest)
    }
    
    func testSearchRecipesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        //Given
        recipeService.saveRecipe(recipeExample3, "Saumon Wasabi")
        recipeService.saveRecipe(recipeExample4, "Lapin Moutarde")
        
        //  let expectation = XCTestExpectation(description: "Wait for queue change.")
    }
    
    func testRootContextIsSavedAfterAddingFavorite() {
        let derivedContext = coreDataStack.newDerivedContext()
        recipeService = RecipeService(managedObjectContext: derivedContext,
                                      coreDataStack: coreDataStack)
        expectation(
            forNotification: .NSManagedObjectContextDidSave,
            object: coreDataStack.mainContext) {
                notification in
                return true
        }
        derivedContext.perform {
            self.recipeService.saveRecipe(self.recipeExample3, "Saumon Wasabi")
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save failed")
        }
    }
    
    // test when id in the code and no data in the Base
    func testGiven2RecipesAnd1BadIdWhenCheckIfRecipeExistThenResultIsFalse() {
        //Given
        recipeService.saveRecipe(recipeExample3, "Saumon Wasabi")
        recipeService.saveRecipe(recipeExample4, "Lapin Moutarde")
        
        let noId = "99"
        
        //When
        let favoriteExist = recipeService.checkIfRecipeIsFavorite(id: noId)
        
        //Then
        XCTAssertFalse(favoriteExist)
        
    }
    
    func testGiven2RecipesAnd1BadIdWhenCheckIfRecipeExistThenResultIsTrue() {
        //Given
        recipeService.saveRecipe(recipeExample3, "Saumon Wasabi")
        recipeService.saveRecipe(recipeExample4, "Lapin Moutarde")
        
        let noId = "04"
        
        //When
        let favoriteExist = recipeService.checkIfRecipeIsFavorite(id: noId)
        
        //Then
        XCTAssertTrue(favoriteExist)
        
    }
    
    // test if a favorite existe for a id
    func testGivenFavoriteStoredWhenCheckIfOneofThemExistThenResultIsTrue() {
        //Given
        recipeService.saveRecipe(recipeExample3, "Saumon Wasabi")
        recipeService.saveRecipe(recipeExample4, "Lapin Moutarde")
        
        let testId = "03"
        
        //When
        let favoriteExist = recipeService.checkIfRecipeIsFavorite(id: testId)
        
        //Then
        XCTAssertTrue(favoriteExist)
        
    }
    // test count favorites, when no favorites
    func testGiven0FavoriteWhenGetFavoriteThenCountEqual0() {
        //Given
        
        //When
        let recipes = recipeService.all
        
        //Then
        XCTAssertEqual(recipes.count, 0)
        
    }
    
    // test erase one favorite when no data
    func testGivenOneFavoriteWhenDeleteFavoriteOK2() {
        //Given
                recipeService.saveRecipe(recipeExample3, "Saumon Wasabi")
                recipeService.saveRecipe(recipeExample4, "Lapin Moutarde")
        //When
        let IsDeleteOk2 = recipeService.deleteAllFavorite()
        
        //Then
        XCTAssertTrue(IsDeleteOk2)
        
    }

    // test erase one favorite when no data
    func testGivenFavoriteWhenDeleteAllFavoriteThenOK() {
        
        //Given
        
        //When
        let IsDeleteOk = recipeService.deleteAllFavorite()
        
        //Then
        XCTAssertTrue(IsDeleteOk)
        
    }
    
    func testGiven2RecipesWhenDelete1RecipeThenCountEqual1() {
        
        //Given
        recipeService.saveRecipe(recipeExample3, "Saumon Wasabi")
        recipeService.saveRecipe(recipeExample4, "Lapin Moutarde")
        
        //When
         _ = recipeService.deleteRecipe("04")
        let recipes = recipeService.all
        
        //Then
        XCTAssertEqual(recipes.count, 1)
    }
    
}
