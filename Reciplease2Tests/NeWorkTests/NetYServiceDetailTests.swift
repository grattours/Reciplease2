//
//  NetYServiceDetailTests.swift
//  Reciplease2Tests
//
//  Created by Luc Derosne on 19/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import XCTest
@testable import Reciplease2

class NetYServiceDetailTests: XCTestCase {
    
    //15 OK Correct nil dataOK
    func testGetDetailShouldSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.GetDetailCorrectData, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "fea252f8-9888-4365-b005-e2c63ed3a776") { success, RecipeDetail, error in
            XCTAssertTrue(success)
            XCTAssertNotNil(RecipeDetail)
            XCTAssertNil(error)
            // XCTAssertEqual(recipe?.name, Optional("French Onion Soup"))
            XCTAssertEqual(RecipeDetail?.name, "French Onion Soup")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    //16 OK Correct error
    func testGetDetailShouldSuccessCallbackIfResponseOKDataAndError() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.GetDetailCorrectData, error: FakeResponseData.networkError)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertTrue(success)
            XCTAssertNotNil(RecipeDetail)
            XCTAssertNil(error)
            // XCTAssertEqual(recipe?.name, Optional("French Onion Soup"))
            XCTAssertEqual(RecipeDetail?.name, "French Onion Soup")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    //17 Onk nil nil
    func testGetDetailShouldFailedCallbackIfResponseCorrectAndNilData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    //18 Ok nil error
    func testGetDetailShouldFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: FakeResponseData.networkError)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    //19 OK incorrect nil
    func diseable_testGetDetailShouldFailedCallbackIfResponseOKIncorrectDataAndNoError() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        //let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            //expectation.fulfill()
        }
        
        //wait(for: [expectation], timeout: 0.01)
    }
    
    //20 OK incorrect error
    func diseable_testGetDetailShouldFailedCallbackIfResponseOKIncorrectDataAndError() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: FakeResponseData.networkError)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        //let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            //expectation.fulfill()
        }
        
        //wait(for: [expectation], timeout: 0.01)
    }
    
    //21 KO correct nil
    func diseable_testGetDetailShouldFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.GetDetailCorrectData, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        // let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            // expectation.fulfill()
        }
        
        // wait(for: [expectation], timeout: 0.01)
    }
    
    //22 KO correct error
    func diseable_testGetDetailShouldFailedCallbackIfNoResponseCorrectDataAndError() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.GetDetailCorrectData, error: FakeResponseData.networkError)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        // let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            // expectation.fulfill()
        }
        
        // wait(for: [expectation], timeout: 0.01)
    }
    
    //23 KO nil nil
    func diseable_testGetDetailShouldFailedCallbackIfResponseKONoDataAndNoError() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: nil, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        // let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            // expectation.fulfill()
        }
        
        // wait(for: [expectation], timeout: 0.01)
    }
    
    //24 KO nil error
    func diseable_testGetDetailShouldFailedCallbackIfResponseKONoDataAndError() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: nil, error: FakeResponseData.networkError)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        // let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            // expectation.fulfill()
        }
        
        // wait(for: [expectation], timeout: 0.01)
    }
    
    //25 KO incorrect nil
    func diseable_testGetDetailShouldFailedCallbackResponseKODataIncorrectAndNoError() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.incorrectData, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        // let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            //expectation.fulfill()
        }
        
        //wait(for: [expectation], timeout: 0.01)
    }
    
    //26 KO incorrect error
    func diseable_testGetDetailShouldFailedCallbackResponseKODataIncorrectAndError() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.incorrectData, error: FakeResponseData.networkError)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        // let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            //expectation.fulfill()
        }
        
        //wait(for: [expectation], timeout: 0.01)
    }
    
    //27 nil nil error
    func diseable_testGetDetailShouldFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        // let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            //expectation.fulfill()
        }
        
        //wait(for: [expectation], timeout: 0.01)
    }
    
    //28 nil incorrect nil
    func diseable_testGetDetailShouldFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let netYSessionFake = NetYSessionFake(fakeResponse: fakeResponse)
        let netYService = NetYService(netYSession: netYSessionFake)
        
        //let expectation = XCTestExpectation(description: "Wait for queue change.")
        netYService.getRecipDetail(id: "") { success, RecipeDetail, error in
            XCTAssertFalse(success)
            XCTAssertNil(RecipeDetail)
            XCTAssertNotNil(error)
            // expectation.fulfill()
        }
        
        //wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    
    
}
