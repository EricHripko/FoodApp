//
//  SavedRecipeServiceProtocol.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 18/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import Foundation

/**
 Protocol for the service that manages saved recipes.
 */
protocol SavedRecipeServiceProtocol {
    /**
     Save the recipe.
     
     - parameters:
       - recipe: Recipe details.
     - returns: true if action was successful, false otherwise.
     */
    func save(recipe: SavedRecipe) -> Bool
    
    /**
     Remove the recipe from saved.
     
     - parameters:
       - id: Unique identifier of the recipe.
     - returns: true if action was successful, false otherwise.
     */
    func unsave(id: String) -> Bool
    
    /**
     List all saved recipes.
     
     - returns: Array of saved recipes or an empty array if an error occured.
     */
    func list() -> [SavedRecipe]
}
