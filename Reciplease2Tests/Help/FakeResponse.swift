//
//  FakeResponse.swift
//  Reciplease2Tests
//
//  Created by Luc Derosne on 18/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
}
