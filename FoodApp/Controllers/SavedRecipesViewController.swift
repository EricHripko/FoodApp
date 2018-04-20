//
//  SavedRecipesViewController.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 19/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

/**
 View controller for the list of saved recipes.
 */
class SavedRecipesViewController: UIViewController {
    @IBOutlet weak var recipesView: UITableView!
    
    /**
     View model for the list of saved recipes.
     */
    var viewModel: SavedRecipesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "Favorites"
        
        self.viewModel = SavedRecipesViewModel([SavedRecipe(id: "asd", name: "Paella", imageURL: "https://img.sndimg.com/food/image/upload/w_896,h_504,c_fill,fl_progressive,q_80/v1/img/recipes/14/81/72/vNuD41wlTe4jnwh8XngJ_Food-com-2017-05-311586.jpg")!, SavedRecipe(id: "asd", name: "Risotto", imageURL: "https://be35832fa5168a30acd6-5c7e0f2623ae37b4a933167fe83d71b5.ssl.cf3.rackcdn.com/4554/pea-and-ham-risotto__hero.jpg?1505386765")!])
        recipesView.dataSource = self.viewModel
    }
}
