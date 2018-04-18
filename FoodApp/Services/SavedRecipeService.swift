//
//  SavedRecipeService.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 18/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import Foundation

/**
 Service that manages saved recipes.
 */
internal class SavedRecipeService : SavedRecipeServiceProtocol {
    /**
     Users document directory.
     */
    static let DocumentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
    
    /**
     URL to persist the recipes.
     */
    internal static let ArchiveURL = DocumentsDirectory.appendingPathComponent("recipes.dat")
    
    /**
     Recipes managed by this service.
     */
    internal var recipes = [SavedRecipe]()
    
    /**
     Initialise a new service with the given recipes.
     
     - parameters:
       - recipes: Recipes.
     */
    internal init(with recipes: [SavedRecipe]) {
        self.recipes = recipes
    }
    
    /**
     Initialise a new service with the recipes loaded from the persistant storage.
     */
    convenience init() {
        if let object = NSKeyedUnarchiver.unarchiveObject(withFile: SavedRecipeService.ArchiveURL.path) {
            self.init(with: object as! [SavedRecipe])
        }
        else {
            print("Failed to unarchive recipes from \(SavedRecipeService.ArchiveURL)")
            self.init(with: [SavedRecipe]())
        }
    }
    
    /**
     Persist changes to saved recipes.
     
     - returns: true if action was successful, false otherwise.
     */
    internal func persist() -> Bool {
        return NSKeyedArchiver.archiveRootObject(recipes, toFile: SavedRecipeService.ArchiveURL.path)
    }
    
    func save(_ recipe: SavedRecipe) -> Bool {
        recipes.append(recipe)
        
        return persist()
    }
    
    func unsave(_ id: String) -> Bool {
        recipes = recipes.filter { $0.id != id }
        
        return persist()
    }
    
    func list() -> [SavedRecipe] {
        return recipes
    }
}
