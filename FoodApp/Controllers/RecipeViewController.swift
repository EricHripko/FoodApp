//
//  RecipeViewController.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

/**
 View controller for Recipe details.
 */
class RecipeViewController: UIViewController {
    @IBOutlet weak var ingridientsView: UITableView!
    @IBOutlet weak var ingridientsViewHeightConstraint: NSLayoutConstraint!
    
    /**
     View model for the igridients list.
     */
    private var viewModel: IngridientsViewModel!
    
    /**
     Button for saving a recipe.
     */
    private var saveButton: UIBarButtonItem!
    
    /**
     Button for removing a recipe from saved.
     */
    private var unsaveButton: UIBarButtonItem!
    
    /**
     Identifier for the recipe to be displayed.
     */
    public var recipeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the the view model (mock for now)
        //TODO Real model
        viewModel = IngridientsViewModel(["###g ingridient, cut into thin slices"])
        ingridientsView.dataSource = viewModel
        
        // Setup navigation buttons
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        unsaveButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(unsaveButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        print("Display recipe id: \(recipeId ?? "None")")
        
        // Set the default button
        navigationItem.rightBarButtonItem = recipeId != nil && ServiceProvider.savedRecipeService.isSaved(recipeId!) ? unsaveButton : saveButton
    }
    
    override func viewDidLayoutSubviews() {
        // Resize the ingridients list to fit content
        ingridientsViewHeightConstraint.constant = ingridientsView.contentSize.height
    }
    
    @objc func saveButtonTapped() {
        guard recipeId != nil else {
            return
        }
        
        let recipe = SavedRecipe(id: recipeId!, name: recipeId!, imageURL: "https://be35832fa5168a30acd6-5c7e0f2623ae37b4a933167fe83d71b5.ssl.cf3.rackcdn.com/4554/pea-and-ham-risotto__hero.jpg?1505386765")!
        if ServiceProvider.savedRecipeService.save(recipe) {
            navigationItem.rightBarButtonItem = unsaveButton
        }
    }
    
    @objc func unsaveButtonTapped() {
        guard recipeId != nil else {
            return
        }

        if ServiceProvider.savedRecipeService.unsave(recipeId!) {
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    @IBAction func instructionsButtonTapped() {
        //TODO Real model
        let url = URL(string: "https://leeds.ac.uk")!
        UIApplication.shared.open(url, options: [:])
    }
}
