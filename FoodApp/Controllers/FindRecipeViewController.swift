//
//  ViewController.swift
//  FoodApp
//
//  Created by Dominykas Brezgys on 06/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

class FindRecipeViewController: UIViewController {

    @IBAction func addIngredientButton(_ sender: Any) {
        performSegue(withIdentifier: "addIngredientSegue", sender: self)
    }
    
    var ingredientRecieved: String? {
        willSet{
            print("Got it!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // segue ViewControllerB -> ViewController
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddIngredientViewController {
            ingredientRecieved = sourceViewController.ingredientPassed
        }
    }


}

