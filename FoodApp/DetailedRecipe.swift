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
    var bigImageUrl: String;
    var ingredients: [String] = [];
    var prepTime: String;
    var cookTime: String;
    var numberOfServings: String;
    
    // Hardcoded constructor with sample data for testing purposes
    override init() {
        bigImageUrl = "https://lh3.googleusercontent.com/Q8n3i7QbQZUqeSggcgEEocDh0_t4ymFsjNq6_LPbNCBDJn_Ppyq50Sg2lHzT8OuGul_qrEWjvddJK4K8XfWR=s360";
        ingredients.append("1 (8oz) box Zatarain's Yellow Rice, cooked according to package.");
        ingredients.append("4 boneless skinless chicken breasts.");
        prepTime = "15 Min";
        cookTime = "7 Hr";
        numberOfServings = "8";
    }
    
    // Constructor with all the props
    init(rBigImageUrl: String, rIngredients: [String], rPrepTime: String, rCookTime: String, rNumberOfServings: String) {
        bigImageUrl = rBigImageUrl;
        ingredients = rIngredients;
        prepTime = rPrepTime;
        cookTime = rCookTime;
        numberOfServings = rNumberOfServings;
    }
}

