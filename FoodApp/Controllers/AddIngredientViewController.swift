//
//  searchIngredientViewController.swift
//  FoodApp
//
//  Created by Dominykas Brezgys on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

/**
 View controller for adding ingredients
 */
class AddIngredientViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    /**
     Array that populates all ingredients pulled from ingredients.plist
     */
    var ingredients = [String]()
    
    /**
     Array that populates filtered ingredients according
     to what user has typed into a searchbar
     */
    var filteredIngredients = [String]()
    
    /**
     Boolean value to determine whether user is typing into the search bar
     */
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        //Populate ingredients list from ingredients.plist file
        let path = Bundle.main.path(forResource: "ingredients", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        ingredients = dict!.object(forKey: "ingredientsArray") as! [String]
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passIngredientSegue" {
            let vc = segue.destination as! FindRecipeViewController
            vc.selectedIngredients.append((sender as! UIButton).titleLabel!.text!)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if isSearching {
            return filteredIngredients.count
        }else{
            return ingredients.count
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as! IngredientTableViewCell
            let ingredient: String!
            
            if isSearching {
                ingredient = filteredIngredients[indexPath.row]
            }else{
                ingredient = ingredients[indexPath.row]
            }
        
            cell.ingredientButton.setTitle(ingredient,for: .normal)
            
            return cell;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            filteredIngredients = ingredients.filter({( ingredient : String) -> Bool in
                return ingredient.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()
        }
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
