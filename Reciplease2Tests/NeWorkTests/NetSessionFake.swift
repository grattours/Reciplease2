//
//  NetSessionFake.swift
//  Reciplease2
//
//  Created by Luc Derosne on 18/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//
import Foundation
import Alamofire
@testable import Reciplease2

class NetYSessionFake: NetYSession {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
        super.init()
    }
    
    override func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)
        let urlRequest = URLRequest(url: url)
        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
