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
    }
    
    // segue AddIngredientViewController -> FindRrecipeViewController
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
    }
}

