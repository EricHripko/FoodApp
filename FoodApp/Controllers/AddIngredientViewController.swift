//
//  searchIngredientViewController.swift
//  FoodApp
//
//  Created by Dominykas Brezgys on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

class AddIngredientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backToFindRecipes(_ sender: Any) {
        performSegue(withIdentifier: "returnIngredientSegue", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
