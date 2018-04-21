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
            guard err == nil else { print("Error!"); return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let map = json as? [String: Any]
                let matches = map?["matches"] as? [Any]
                if matches?.count != 0 {
                    for match in matches! {
                        let each = match as? [String: Any]
                        let imageArray = each?["smallImageUrls"] as? [String]
                        var image = ""
                        if imageArray != nil && imageArray?.count != 0 {
                            image = imageArray![0]
                        }
                        // ID and name forcibly unwrapped as its guaranteed for them to be present in API docs
                        let recipeObj = Recipe(id: each!["id"]! as! String, name: each!["recipeName"]! as! String, smallImageURL: image)
                        recipeObjects.append(recipeObj)
                    }
                }
                else {
                    print("No matches found for the searched ingredients!")
                    return
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
        // Create URL
        let url = "\(domain)recipe/\(id)?_app_id=\(app_id)&_app_key=\(key)"
        guard let urlObj = URL(string: url) else { return }
        
        // Async call to API
        URLSession.shared.dataTask(with: urlObj) { (data, response, err) in
            // Ensure response exists, else return
            guard let data = data else { return }
            guard err == nil else { print("Error!"); return }
            
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
                return
            }
        }.resume()
    }
}
