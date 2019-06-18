//
//  NetService.swift
//  Reciplease2
//
//  Created by Luc Derosne on 18/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import Alamofire

class NetService {
    private let netSession: NetProtocol
    
    init(netSession: NetProtocol = NetSession()) {
        self.netSession = netSession
    }
    
    let ApiKeyRequest = valueForAPIKey(named:"API_Key_Yummly")
    let ApiIdRequest = valueForAPIKey(named:"API_Id_Yummly")
    
    // search data with endpoint and ingredient list
    func getRecipes(_ ingredientsList:[String], callback: @escaping(Bool, RecipeStruc?) -> Void) {
        var list = ""
        for ingredient in ingredientsList {
            list +=  ingredient + "+"
        }
        list = String(list.dropLast())
        guard let url = URL(string: createRecipeRequest(list)) else { return }
        netSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                callback(false, nil)
                return
            }
            guard let data = responseData.data else {
                callback(false, nil)
                return
            }
            guard let responseJson = try? JSONDecoder().decode(RecipeStruc.self, from: data) else {
                callback(false, nil)
                return
            }
            callback(true, responseJson)
        }
    }
    
    // compose url with ingredients list
    func createRecipeRequest(_ list:String) -> String {
        let OptionsRequest = "requirePictures=true"
        let  URLString = "https://api.yummly.com/v1/api/recipes?_app_id=\(ApiIdRequest)&_app_key=\(ApiKeyRequest)&q=\(list)&\(OptionsRequest)"
        return URLString
    }
    
    // compose url with id of the choosen recipe
    func createRecipeDetailRequest(id: String) -> String {
        let  URLString = "https://api.yummly.com/v1/api/recipe/\(id)?_app_id=\(ApiIdRequest)&_app_key=\(ApiKeyRequest)"
        return URLString
    }
    
    // search data with endpoint and id
    func getRecipDetail(id: String, callback: @escaping(Bool, RecipeDetail?) -> Void) {
        guard let url = URL(string: createRecipeDetailRequest(id: id)) else {
            print("error url getRecipDetail")
            return }
        netSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                callback(false, nil)
                return
            }
            guard let data = responseData.data else {
                callback(false, nil)
                return
            }
            guard let responseJson = try? JSONDecoder().decode(RecipeDetail.self, from: data) else {
                callback(false, nil)
                return
            }
            callback(true, responseJson)
            
        }
    }
    
}
