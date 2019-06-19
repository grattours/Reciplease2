//
//  RecipeJson.swift
//
//
//  Created by Luc Derosne on 12/06/2019.
//

import Foundation

// JSON Struc for API yummly
struct RecipeStruc: Decodable {
    let matches: [Infos]
}

struct Infos: Decodable {
    let imageUrlsBySize: ImageUrlsBySize
    let sourceDisplayName: String
    let ingredients: [String]
    let id: String
    let smallImageUrls: [String]
    let recipeName: String
    let totalTimeInSeconds: Int
    let rating: Int
}

struct ImageUrlsBySize: Decodable {
    let the90: String
    
    enum CodingKeys: String, CodingKey {
        case the90 = "90"
    }
}

