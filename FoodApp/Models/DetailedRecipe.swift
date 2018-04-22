//
//  DetailedRecipe.swift
//  FoodApp
//
//  Created by Boris Benchev on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

// A simple class to represent a DetailedRecipe
class DetailedRecipe {
    let name : String
    let imageURL: String?
    let ingredients: [String]
    let prepTime: String?
    let cookTime: String?
    let numberOfServings: Int?
    let sourceURL: String?
    
    /**
     @param name             - Recipe name
     @param imageURL         - Optional String as it might not be present in API response
     @param ingredients      - Array of Strings with recipe ingredients
     @param prepTime         - Recipe preparation time. Optional as it might not be present in API response
     @param cookTime         - Recipe cooking time. Optional as it might not be present in API response
     @param numberOfServings - Number of servings for the recipe. Optional as it might not be present in API response
    */
    init(_ name: String, _ imageURL: String?, _ ingredients: [String], _ prepTime: String?, _ cookTime: String?, _ numberOfServings: Int?, _ sourceURL: String?) {
        self.name = name
        self.imageURL = imageURL
        self.ingredients = ingredients
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.numberOfServings = numberOfServings
        self.sourceURL = sourceURL
    }
}

