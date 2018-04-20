//
//  DetailedRecipe.swift
//  FoodApp
//
//  Created by Boris Benchev on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

// A simple class to represent a DetailedRecipe
class DetailedRecipe: Recipe {
    let bigImageURL: String;
    let ingredients: [String];
    let prepTime: String;
    let cookTime: String;
    let numberOfServings: Int;
    
    
    init(id: String, name: String, smallImageURL: String, bigImageURL: String, ingredients: [String], prepTime: String, cookTime: String, numberOfServings: Int) {
        self.bigImageURL = bigImageURL;
        self.ingredients = ingredients;
        self.prepTime = prepTime;
        self.cookTime = cookTime;
        self.numberOfServings = numberOfServings;
        super.init(id: id, name: name, smallImageURL: smallImageURL);
    }
}

