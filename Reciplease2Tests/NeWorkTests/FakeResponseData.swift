//
//  FakeResponseData.swift
//  Reciplease2Tests
//
//  Created by Luc Derosne on 18/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import Alamofire

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static var GetRecipeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "GetRecipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var GetDetailCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "GetDetail", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
}
