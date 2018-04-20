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
    
    func queryAPI() {
        guard let urlObj = URL(string: url) else { return }
        URLSession.shared.dataTask(with: urlObj) { (data, response, err) in
            guard let data = data else { return }
            
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString)
        }
        
    }
}
