//
//  ApiResponseHandler.swift
//  FoodApp
//
//  Created by Boris Benchev on 20/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

class ApiResponseHandler {
    let domain: String
    let endpoint: String
    private let app_id = "d88aeda7"
    private let key = "c5805a87b146f8f9e529b1adab930d37"
    let url: String
    
    init?(endpoint: String, ingredients: String) {
        self.endpoint = endpoint
        switch endpoint {
        case "recipe":
            domain = "https://api.yummly.com/v1/api/recipe/"
            url = domain + "Crockpot-Cheesy-Chicken-_-Rice-2132197" + "?_app_id=" + app_id + "&_app_key=" + key
            print(url)
        case "recipes":
            domain = "https://api.yummly.com/v1/api/recipes"
            url = domain + "?_app_id=" + app_id + "&_app_key=" + key + "&q=" + ingredients
            print(url)
        default:
            return nil
        }
    }
    
    // Gets all the recipes for the provided ingredients
    func getRecipes(onCompletion: @escaping ([Recipe]) -> Void) {
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
    
    func getRecipe(onCompletion: @escaping (DetailedRecipe) -> Void) {
        guard let urlObj = URL(string: url) else { return }
        URLSession.shared.dataTask(with: urlObj) { (data, response, err) in
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let map = json as? [String: Any]
                let ingredients = map!["ingredientLines"] as? [String]
                let cookTime = map!["cookTime"]
                let prepTime = map!["prepTime"]
                let numberOfServings = map!["numberOfServings"]
                let imagesArray = map!["images"] as? [Any]
                let images = imagesArray![0] as? [String: Any]
                let recipe = DetailedRecipe(id: "Crockpot-Cheesy-Chicken-_-Rice-2132197", name: "Chicken & Rice", smallImageURL:
                    "https://lh3.googleusercontent.com/Q8n3i7QbQZUqeSggcgEEocDh0_t4ymFsjNq6_LPbNCBDJn_Ppyq50Sg2lHzT8OuGul_qrEWjvddJK4K8XfWR=s90", bigImageURL: images!["hostedLargeUrl"]! as! String, ingredients: ingredients!, prepTime: prepTime as! String, cookTime: cookTime as! String, numberOfServings: numberOfServings as! Int  )
                onCompletion(recipe)
            }
            catch let jsonErr {
                print("Error parsing JSON", jsonErr)
            }
        }.resume()
    }
}
