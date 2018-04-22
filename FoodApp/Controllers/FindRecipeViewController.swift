//
//  ViewController.swift
//  FoodApp
//
//  Created by Dominykas Brezgys on 06/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

class FindRecipeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: RecipesViewModel!
    
    
    @IBAction func addIngredientButton(_ sender: Any) {
        performSegue(withIdentifier: "addIngredientSegue", sender: self)
    }
    
    /**
     selectedIngredients array, which updates the collection view every time it's set
     */
    var selectedIngredients: [String] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "Search"
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // segue AddIngredientViewController -> FindRrecipeViewController
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        ServiceProvider.apiService.getRecipes(ingredients: selectedIngredients) {
            recipes in DispatchQueue.main.async {
                self.dataBind(recipes)
            }
        }
    }
    
    func dataBind(_ recipes: [Recipe]) {
        viewModel = RecipesViewModel(with: recipes, noData: "Couldn't load data")
        tableView.dataSource = viewModel
        tableView.setNeedsLayout()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return selectedIngredients.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedIngredientCell", for: indexPath) as! SelectedIngredientCollectionViewCell
        
        cell.ingredientLabel.text = selectedIngredients[indexPath.row]
        cell.removeButton.layer.setValue(indexPath.row, forKey: "index")
        cell.removeButton.addTarget(self, action:#selector(removeIngredient(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func removeIngredient(sender:UIButton) {
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        selectedIngredients.remove(at: i)
    }

}

