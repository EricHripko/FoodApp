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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // We have data
        if savedRecipes.count > 0 {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
            return 1
        }
        
        // No recipes saved
        let placeholder: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        placeholder.text = "Saved recipes are added here"
        placeholder.textColor = UIColor.darkGray
        placeholder.textAlignment = .center
        tableView.backgroundView = placeholder
        tableView.separatorStyle = .none
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedRecipes.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTemplate") as! RecipeTableViewCell
        
        let savedRecipe = savedRecipes[indexPath.row]
        cell.name = savedRecipe.name
        if let image = imageCache[savedRecipe.imageURL] {
            // Pull the image from cache
            cell.icon = image
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
                        cell.icon = image
                    }
                }
            }
        }
        
        return cell;
    }
}
