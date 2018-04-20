//
//  SavedRecipesViewModel.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 19/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

/**
 View model for displaying a list of saved recipes.
 Enables user to delete saved recipes.
 */
class SavedRecipesViewModel : RecipesViewModel {
    /**
     Create a new view model for displaying recipes.
     
     - parameters:
       - savedRecipes: Recipes saved by the user.
     */
    init(with savedRecipes: [SavedRecipe]) {
        super.init(with: savedRecipes, noData: "Saved recipes are added here")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        // Remove recipe from persistent storage
        let index = indexPath.row
        let recipeId = recipes[index].id
        guard ServiceProvider.savedRecipeService.unsave(recipeId) else {
            return
        }
        
        // Remove recipe from this view model
        recipes.remove(at: index)
        
        // Remove recipe from the table view
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
