//
//  RecipeJsonDetails.swift
//  
//
//  Created by Luc Derosne on 12/06/2019.
//

import Foundation

struct RecipeDetail: Decodable {
    let id: String
    let name: String
    let ingredientLines: [String]
    let totalTimeInSeconds: Int
    let rating: Int
    var images: [Image]
    let source: Source
}

struct Image: Decodable {
    var hostedLargeUrl: URL?
}

struct Source: Decodable {
    let sourceRecipeUrl: String?
}
