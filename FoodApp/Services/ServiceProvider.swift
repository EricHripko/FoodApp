//
//  ServiceProvider.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 20/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

/**
 Provider that holds all the services used by the app.
 All services have singleton lifecycle.
 */
struct ServiceProvider {
    /**
     Service for managing saved recipes.
     */
    static let savedRecipeService: SavedRecipeServiceProtocol = SavedRecipeService()
    
    // This is a static struct and it should not be initialised
    private init() {
    }
}
