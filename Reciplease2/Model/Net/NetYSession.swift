//
//  NetSession.swift
//  
//
//  Created by Luc Derosne on 18/06/2019.
//

import Foundation
import Alamofire

class NetYSession: NetYProtocol {
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            completionHandler(responseData)
        }
    }
}
