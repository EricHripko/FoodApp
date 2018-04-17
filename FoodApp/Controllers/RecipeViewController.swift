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
    var viewModel: IngridientsViewModel!
    
    /**
     Button for saving a recipe.
     */
    var saveButton: UIBarButtonItem!
    /**
     Button for removing a recipe from saved.
     */
    var unsaveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the the view model (mock for now)
        //TODO Real model
        self.viewModel = IngridientsViewModel(["###g ingridient, cut into thin slices"])
        ingridientsView.dataSource = self.viewModel
        
        // Setup navigation buttons
        self.saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        self.unsaveButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(unsaveButtonTapped))
        
        // Set the default button
        //TODO Real model
        self.navigationItem.rightBarButtonItem = self.saveButton
    }
    
    override func viewDidLayoutSubviews() {
        // Resize the ingridients list to fit content
        ingridientsViewHeightConstraint.constant = ingridientsView.contentSize.height
    }
    
    @objc func saveButtonTapped() {
        //TODO
        print("Saving")
        self.navigationItem.rightBarButtonItem = self.unsaveButton
    }
    
    @objc func unsaveButtonTapped() {
        //TODO
        print("Unsaving")
        self.navigationItem.rightBarButtonItem = self.saveButton
    }
    
    @IBAction func instructionsButtonTapped() {
        //TODO Real model
        let url = URL(string: "https://leeds.ac.uk")!
        UIApplication.shared.open(url, options: [:])
    }
}
