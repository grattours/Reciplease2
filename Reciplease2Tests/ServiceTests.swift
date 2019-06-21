//
//  ServiceTests.swift
//  Reciplease2Tests
//
//  Created by Luc Derosne on 21/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import XCTest
@testable import Reciplease2

class ServiceTests: XCTestCase {
    
//1    Given recipe   Then everything allwright   When success recipe non error dataok
    func testGiven1IngredientWhenGetIngredientThenCountEqua1() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.GetRecipeCorrectData, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        //  let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        netYService.getRecipes(["Saumon Wasabi"]) { (success, RecipeStruc, error) in
            XCTAssertTrue(success)
            XCTAssertNotNil(RecipeStruc)
            XCTAssertNil(error)
            XCTAssertEqual(RecipeStruc?.matches[0].recipeName, "French Onion Soup")
            //   expectation.fulfill()
        }
        
        //     wait(for: [expectation], timeout: 10)
    }
    
//2 OK Correct Error
        func testGetRecipeShouldFailedCallbackIfIncorrectResponse() {
            let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.GetRecipeCorrectData, error: FakeResponseData.networkError)
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
            netYService.getRecipes(["Saumon Wasabi"]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                // expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }

    //3 OK  nil nil
        func testGetRecipeShouldFailedCallbackIfResponseCorrectAndNilData() {
            let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
            netYService.getRecipes([" "]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                // expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }
    //4 OK  nil error
        func testGetRecipeShouldFailedCallbackIfResponseCorrectAndNilDataAndError() {
            let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: FakeResponseData.networkError)
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
            netYService.getRecipes(["Saumon Wasabi"]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                // expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }
     //5 OK incorrect nil
        func testGetRecipeShouldFailedCallbackIfIncorrectData() {
            let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
            netYService.getRecipes([" "]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                //expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }
    //6 Ok incorrect error
        func testGetRecipeShouldFailedCallbackIfNoDataAndError() {
            let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: FakeResponseData.networkError)
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
            netYService.getRecipes([" "]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                //   expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }
    
    //7 KO correct nil
        func testGetRecipeShouldFailedCallbackIfNoResponseDataAndNoError() {
            let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.GetRecipeCorrectData, error: nil)
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
            netYService.getRecipes([" "]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                // expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }
    
    //8 KO correct nil
        func testGetRecipeShouldFailedCallbackIfNoResponseDataAndError() {
            let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.GetRecipeCorrectData, error: FakeResponseData.networkError )
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
            netYService.getRecipes([" "]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                // expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }
    //9 KO nil nil
        func testGetRecipeShouldFailedCallbackIfIError() {
            let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: nil, error: nil)
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
             netYService.getRecipes([" "]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                // expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }
    
    //10 KO nil error
        func testGetRecipeShouldFailedCallbackIfResponseKONoDataAndError() {
            let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: nil, error: FakeResponseData.networkError)
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
            netYService.getRecipes([" "]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                // expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }
    
    //11 KO incorrect  nil
        func testGetRecipeShouldFailedCallbackIfResponseKOIncorrectDataAndNoError() {
            let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.incorrectData, error: nil)
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
            netYService.getRecipes([" "]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                // expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }
    
    
//12 KO incorrect  error
        func testGetRecipeShouldFailedCallbackIfResponseKOIncorrectDataAndError() {
            let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.incorrectData, error: FakeResponseData.networkError)
            let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
            let netYService = NetYService(netYSession: netYSessionFake)
    
            // let expectation = XCTestExpectation(description: "Wait for queue change.")
            netYService.getRecipes([" "]) { (success, RecipeStruc, error) in
                XCTAssertFalse(success)
                XCTAssertNil(RecipeStruc)
                XCTAssertNotNil(error)
                // expectation.fulfill()
            }
    
            // wait(for: [expectation], timeout: 0.01)
        }
    
//13 nil nil error
    func testGetRecipeShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)

    //    let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipes([""]) { success, RecipeStruc, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeStruc)
            XCTAssertNotNil(error)
      //      expectation.fulfill()
        }

       // wait(for: [expectation], timeout: 0.01)
    }

//14 nil incorrect nil
    func testGetRecipeShouldFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        //    let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipes([" "]) { (success, RecipeStruc, error) in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeStruc)
            XCTAssertNotNil(error)
            //      expectation.fulfill()
        }
        
        //    wait(for: [expectation], timeout: 30)
    }

 }
