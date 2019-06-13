//
//  RecipeJson.swift
//  
//
//  Created by Luc Derosne on 12/06/2019.
//

import Foundation

// JSON Struc for API yummly
struct RecipeStruc: Decodable {
    //let totalMatchCount: Int
    //    let criteria: Criteria?
    let matches: [Infos]
    //    let facetCounts: FacetCounts
    //    let totalMatchCount: Int
    //    let attribution: Attribution
}

//struct Attribution: Codable {
//    let html: String
//    let url: String
//    let text: String
//    let logo: String
//}

//struct Criteria: Codable {
//    let q: String
//    let requirePictures: Bool
//    let allowedIngredient, excludedIngredient: JSONNull?
//}

//struct FacetCounts: Codable {
//}

struct Infos: Decodable {
    let imageUrlsBySize: ImageUrlsBySize
    let sourceDisplayName: String
    let ingredients: [String]
    let id: String
    let smallImageUrls: [String]
    let recipeName: String
    let totalTimeInSeconds: Int
    //    let attributes: Attributes?
    //    let flavors: Flavors?
    let rating: Int
}

//struct Attributes: Codable {
//    let course, holiday, cuisine: [String]?
//}
//
//struct Flavors: Codable {
//    let piquant, meaty, bitter, sweet: Double
//    let sour, salty: Double
//}

struct ImageUrlsBySize: Decodable {
    let the90: String
    
    enum CodingKeys: String, CodingKey {
        case the90 = "90"
    }
}

//// Decode getUrl response
//struct URLResponse: Decodable {
//    let source: Source
//}
//struct Source: Decodable {
//    let sourceRecipeUrl: URL
//    let sourceDisplayName: String
//}
