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
    
    func makeRequest() {
        var objects = [Recipe]()
        guard let urlObj = URL(string: url) else { return }
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
                    objects.append(recipeObj)
                }
            }
            catch let jsonErr {
                print("Error parsing JSON", jsonErr)
            }
            print(objects)
        }.resume()
    }
}
