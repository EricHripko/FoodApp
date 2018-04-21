//
//  ApiResponseHandler.swift
//  FoodApp
//
//  Created by Boris Benchev on 20/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

/**
 Class used to query the API
 */
class ApiResponseHandler {
    private let domain = "https://api.yummly.com/v1/api/"
    private let app_id = "d88aeda7"
    private let key = "c5805a87b146f8f9e529b1adab930d37"
    let ingredients: [String]
    var recipeId = ""
    
    /**
    Initialiser used for getRecipes()
     @param ingredients - array of ingredients
    */
    init(ingredients: [String]) {
        self.ingredients = ingredients
    }
    
    /**
     Initialiser used for getRecipe()
     @param recipeId - the ID of recipe to be queried
     */
    init(recipeId: String) {
        self.recipeId = recipeId
        self.ingredients = []
    }
    
    /**
     @param ingredients - array of ingredients
     @param onCompletion - callback with populated array of Recipe objects
     */
    func getRecipes(ingredients: [String], onCompletion: @escaping ([Recipe]) -> Void) {
        // Create url string
        let ingredientsString = ingredients.joined(separator: "+")
        let url = "\(domain)recipes?_app_id=\(app_id)&_app_key=\(key)+&q=\(ingredientsString)"
        
        // Initialise the array
        var recipeObjects = [Recipe]()
        guard let urlObj = URL(string: url) else { return }
        
        // Async call to dataTask and populate ojects Array
        URLSession.shared.dataTask(with: urlObj) { (data, response, err) in
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let map = json as? [String: Any]
                let matches = map!["matches"] as? [Any]
                for match in matches! {
                    let each = match as? [String: Any]
                    let imageArray = each!["smallImageUrls"] as? [String]
                    let image = imageArray![0]
                    let recipeObj = Recipe(id: each!["id"]! as! String, name: each!["recipeName"]! as! String, smallImageURL: image)
                    recipeObjects.append(recipeObj)
                }
            }
            catch let jsonErr {
                print("Error parsing JSON", jsonErr)
            }
            onCompletion(recipeObjects)
        }.resume()
    }
    
    /**
     @param id - the ID for recipe to look for
     @param onCompletion - callback containing the DetailedRecipe object
     */
    func getRecipe(id: String, onCompletion: @escaping (DetailedRecipe) -> Void) {
        // Create url string
        let url = "\(domain)recipe/\(id)?_app_id=\(app_id)&_app_key=\(key)"
        
        guard let urlObj = URL(string: url) else { return }
        // Async call to API
        URLSession.shared.dataTask(with: urlObj) { (data, response, err) in
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let map = json as? [String: Any]
                let ingredients = map!["ingredientLines"] as? [String]
                let name = map!["name"]
                let cookTime = map!["cookTime"]
                let prepTime = map!["prepTime"]
                let numberOfServings = map!["numberOfServings"]
                let imagesArray = map!["images"] as? [Any]
                let images = imagesArray![0] as? [String: Any]
                let recipe = DetailedRecipe(id, name as! String, images!["hostedLargeUrl"]! as! String, ingredients!, prepTime as! String, cookTime as! String, numberOfServings as! Int)
                onCompletion(recipe)
            }
            catch let jsonErr {
                print("Error parsing JSON", jsonErr)
            }
        }.resume()
    }
}
