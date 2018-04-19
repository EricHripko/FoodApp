//
//  searchIngredientViewController.swift
//  FoodApp
//
//  Created by Dominykas Brezgys on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

class AddIngredientViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var ingredients = [String]()
    var filteredIngredients = [String]()
    
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        ingredients = [
            "Onion", "Garlic", "Tomato", "Pasta",
        ]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        //CHANGE TEXT OF button
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
            //filteredIngredients = ingredients.filter({$0.name == searchBar.text})
            tableView.reloadData()
        }
        
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
