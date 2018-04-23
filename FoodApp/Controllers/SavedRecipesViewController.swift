//
//  SavedRecipesViewController.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 19/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

/**
 View controller for the list of saved recipes.
 */
class SavedRecipesViewController: UIViewController {
    @IBOutlet weak var recipesView: UITableView!
    
    /**
     View model for the list of saved recipes.
     */
    var viewModel: SavedRecipesViewModel!

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Favorites"
        
        // Load recipes and display them
        let recipes = ServiceProvider.savedRecipeService.list()
        self.viewModel = SavedRecipesViewModel(with: recipes)
        recipesView.dataSource = self.viewModel
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "savedRecipeDetail" {
            return
        }
        
        let destination = segue.destination as? RecipeViewController
        let recipeId = viewModel.selectedRecipe(for: recipesView)
        destination?.recipeId = recipeId?.id
    }
}
