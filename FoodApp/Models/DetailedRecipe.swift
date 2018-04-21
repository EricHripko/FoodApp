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
    let imageURL: String;
    let ingredients: [String];
    let prepTime: String;
    let cookTime: String;
    let numberOfServings: Int;
    
    
    init(_ id: String, _ name: String, _ imageURL: String, _ ingredients: [String], _ prepTime: String, _ cookTime: String, _ numberOfServings: Int) {
        self.name = name
        self.imageURL = imageURL;
        self.ingredients = ingredients;
        self.prepTime = prepTime;
        self.cookTime = cookTime;
        self.numberOfServings = numberOfServings;
    }
}

