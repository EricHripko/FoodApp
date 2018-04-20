//
//  SavedRecipesViewModel.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 19/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import Foundation

import UIKit

/**
 View model for displaying a list of recipes.
 */
class SavedRecipesViewModel : NSObject, UITableViewDataSource {
    /**
     Recipes to be displayed.
     */
    private let savedRecipes: [SavedRecipe]
    
    /**
     Cache of images.
     */
    private var imageCache = [String: UIImage]()
    
    /**
     Create a new view model for displaying recipes.
     
     - parameters:
       - savedRecipes: Recipes saved by the user.
     */
    init(_ savedRecipes: [SavedRecipe]) {
        self.savedRecipes = savedRecipes;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedRecipes.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTemplate") as! RecipeTableViewCell
        
        let savedRecipe = savedRecipes[indexPath.row]
        cell.textView?.text = savedRecipe.name
        if let image = imageCache[savedRecipe.imageURL] {
            // Pull the image from cache
            cell.iconView?.image = image
        }
        else {
            // Download the image
            if let url = URL(string: savedRecipe.imageURL) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        let image = UIImage(data: data!)
                        self.imageCache[savedRecipe.imageURL] = image
                        // Set the image and recalculate layout
                        cell.iconView?.image = image
                    }
                }
            }
        }
        
        return cell;
    }
}
