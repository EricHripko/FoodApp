//
//  ViewController.swift
//  FoodApp
//
//  Created by Dominykas Brezgys on 06/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

class FindRecipeViewController: UIViewController {

    var selectedIngredients: [String] = [] {
        didSet{
            print(selectedIngredients)
        }
    }
    
    @IBAction func addIngredientButton(_ sender: Any) {
        performSegue(withIdentifier: "addIngredientSegue", sender: self)
    }
    
//    var ingredientRecieved: String? {
//        willSet{
//            selectedIngredients.append(newValue!)
//            print(selectedIngredients)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "Search"
//        let handler = ApiResponseHandler(endpoint: "recipes", ingredients: "chicken+rice")
//        handler?.getRecipes { (recipesArray) in
//            // recipesArray now contains the array of objects to be rendered on the view
//        }
        let handler = ApiResponseHandler(endpoint: "recipe", ingredients: "")
        handler?.getRecipe { (recipe) in
            print(recipe)
        }
    }
    
    // segue AddIngredientViewController -> FindRrecipeViewController
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
    }
}

