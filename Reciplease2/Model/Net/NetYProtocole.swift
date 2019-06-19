//
//  NetProtocole.swift
//  Reciplease2
//
//  Created by Luc Derosne on 18/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import Alamofire

protocol NetYProtocol {
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}
