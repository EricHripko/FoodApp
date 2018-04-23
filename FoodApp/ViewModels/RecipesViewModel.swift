//
//  RecipesViewModel.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 20/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

/**
 View model for displaying a list of recipes.
 */
class RecipesViewModel : NSObject, UITableViewDataSource {
    /**
     Recipes to be displayed.
     */
    var recipes: [RecipeProtocol]

    /**
     Cache of images.
     */
    private var _imageCache = [String: UIImage]()
    
    /**
     Message to be displayed when no data is present.
     */
    private var _noDataMessage: String
    
    /**
     Create a new view model for displaying recipes.
     
     - parameters:
       - recipes: Recipes to be displayed.
     */
    init(with recipes: [RecipeProtocol], noData: String) {
        self.recipes = recipes
        _noDataMessage = noData
    }
    
    /**
     Identify the currently selected recipe, if any.
     
     - parameters:
       - tableView: Source table view.
     - returns: Selected recipe or nil otherwise.
     */
    func selectedRecipe(for tableView: UITableView) -> RecipeProtocol? {
        guard let index = tableView.indexPathForSelectedRow?.row else {
            return nil
        }
        
        return recipes[index]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // We have data
        if recipes.count > 0 {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
        }
        else {
            // No recipes saved
            let placeholder: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            placeholder.text = _noDataMessage
            placeholder.textColor = UIColor.darkGray
            placeholder.textAlignment = .center
            tableView.backgroundView = placeholder
            tableView.separatorStyle = .none
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as! RecipeTableViewCell
        
        let recipe = recipes[indexPath.row]
        cell.name = recipe.name
        if let image = _imageCache[recipe.imageURL] {
            // Pull the image from cache
            cell.icon = image
        }
        else {
            // Download the image
            if let url = URL(string: recipe.imageURL) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        guard data != nil else {
                            return
                        }
                        
                        let image = UIImage(data: data!)
                        self._imageCache[recipe.imageURL] = image
                        // Set the image and recalculate layout
                        cell.icon = image
                    }
                }
            }
        }
        
        return cell
    }
}
