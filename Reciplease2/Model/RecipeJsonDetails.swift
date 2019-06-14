//
//  RecipeJsonDetails.swift
//  Reciplease2
//
//  Created by Luc Derosne on 14/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

struct RecipeDetail: Decodable {
    let id: String
    let name: String
    let ingredientLines: [String]
    let totalTimeInSeconds: Int
    let rating: Int
    var images: [Image?]
    let source: Source
}

struct Image: Decodable {
    var hostedLargeUrl: URL?
}

struct Source: Decodable {
    let sourceRecipeUrl: String?
}
