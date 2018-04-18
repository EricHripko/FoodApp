//
//  Recipe.swift
//  FoodApp
//
//  Created by Boris Benchev on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

// A simple class to represent a Recipe
class Recipe {
    let id: String;
    let name: String;
    let smallImageUrl: String;
    
    init(rId: String, rName: String, rSmallImageUrl: String) {
        id = rId;
        name = rName;
        smallImageUrl = rSmallImageUrl;
    }
    
    // Hardcoded constructor with sample data for testing purposes
    init() {
        id = "Crockpot-Cheesy-Chicken-_-Rice-2132197";
        name = "Crockpot Cheesy Chicken & Rice";
        smallImageUrl = "https://lh3.googleusercontent.com/Q8n3i7QbQZUqeSggcgEEocDh0_t4ymFsjNq6_LPbNCBDJn_Ppyq50Sg2lHzT8OuGul_qrEWjvddJK4K8XfWR=s90";
    }
}
