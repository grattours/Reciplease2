//
//  ServiceTests.swift
//  Reciplease2Tests
//
//  Created by Luc Derosne on 21/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import XCTest
@testable import Reciplease2

class ServiceTests: XCTestCase {
    
    //1
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.GetRecipeCorrectData, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        netYService.getRecipes([""]) { success, RecipeStruc, error in
            XCTAssertTrue(success)
            XCTAssertNotNil(RecipeStruc)
            XCTAssertNil(error)
            XCTAssertEqual(RecipeStruc?.matches[0].recipeName, "French Onion Soup")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    //2
    func testGetRecipeShouldFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipes([""]) { success, RecipeStruc, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeStruc)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    //3
    func testGetRecipeShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipes([""]) { success, RecipeStruc, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeStruc)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    //4
    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipes([""]) { success, RecipeStruc, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeStruc)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    //5
    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipes([""]) { success, RecipeStruc, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeStruc)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    //6
    func testGetRecipeShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipes([""]) { success, RecipeStruc, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeStruc)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
}
