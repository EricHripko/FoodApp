//
//  RecipeProtocol.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 20/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

/**
 Protocol that describes basic information about the recipe.
 */
protocol RecipeProtocol {
    /**
     Unique identifier for the recipe.
     */
    var id: String { get }
    
    /**
     Name of the recipe.
     */
    var name: String  { get }
    
    /**
     Image for the recipe.
     */
    var imageURL: String  { get }
}
