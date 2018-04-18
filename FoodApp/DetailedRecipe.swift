//
//  DetailedRecipe.swift
//  FoodApp
//
//  Created by Boris Benchev on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

// A simple class to represent a Recipe
class DetailedRecipe: Recipe {
    var bigImageUrl = "https://lh3.googleusercontent.com/Q8n3i7QbQZUqeSggcgEEocDh0_t4ymFsjNq6_LPbNCBDJn_Ppyq50Sg2lHzT8OuGul_qrEWjvddJK4K8XfWR=s360";
    var ingredients: [String] = ["1 (8oz) box Zatarain's Yellow Rice, cooked according to package.", "4 boneless skinless chicken breasts."];
    var prepTime = "15 Min";
    var cookTime = "7 Hr";
    var numberOfServings = "8";
    
    override init() {
        super.init();
    }
    
    init(rId: String, rName: String, rSmallImageUrl: String, rBigImageUrl: String, rIngredients: [String], rPrepTime: String, rCookTime: String, rNumberOfServings: String) {
        bigImageUrl = rBigImageUrl;
        ingredients = rIngredients;
        prepTime = rPrepTime;
        cookTime = rCookTime;
        numberOfServings = rNumberOfServings;
        super.init(rId, rName, rSmallImageUrl);
    }
}

