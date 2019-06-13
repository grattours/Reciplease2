//
//  AlertsEnum.swift
//  Reciplease2
//
//  Created by Luc Derosne on 12/06/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//


import Foundation

// All texts for alert messages
enum errorMessage: String {
    // global  Error messages
    case networkError = "NetWork error"
    case unknowError = "Unknow error"
    case errorNoSource = "No source"
    // Search recipe Error messages
    case errorIngredientneeded = "need some ingredients"
    case errorRecipeLoaded = "Error no recipe loaded"
    case errorNoDelete = "No delete possible"
    //  Detail favorite Error messages
    case errorAlwayFavorite = "Always favorite"
    case errorIdNoValid = "Error Delete no valid Id"
    case errorDeleteFavorite = "Error Delete failded"
}
