//
//  ApiKeysManager.swift
//  Reciplease2
//
//  Created by Luc Derosne on 22/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

final class ApiKeysManager {
    private lazy var apiKeys: NSDictionary = {
        guard let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist") else {
            fatalError("ApiKeys.plist not found")
        }
        return NSDictionary(contentsOfFile: path) ?? [:]
    }()
    var yummlyId: String {
        return apiKeys["API_Id_Yummly"] as? String ?? String()
    }
    var yummlyKey: String {
        return apiKeys["API_Key_Yummly"] as? String ?? String()
    }
}
