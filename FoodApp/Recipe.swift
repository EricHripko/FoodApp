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
    let smallImageURL: String
    
    init(id: String, name: String, smallImageURL: String) {
        self.id = id;
        self.name = name;
        self.smallImageURL = smallImageURL;
    }
}
