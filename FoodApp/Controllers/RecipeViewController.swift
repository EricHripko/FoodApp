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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var prepTextView: UILabel!
    @IBOutlet weak var cookTextView: UILabel!
    @IBOutlet weak var servesTextView: UILabel!
    
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
    
    /**
     URL for the image that describes this recipe.
     */
    private var imageURL: String?
    
    /**
     Get or set the name of the recipe displayed by this control.
     */
    private var name: String? {
        get {
            return navigationItem.title
        }
        set(value) {
            navigationItem.title = value
        }
    }
    
    /**
     Get or set the image displayed by this control.
     */
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set(value) {
            imageView.image = value
            
            if value == nil {
                return
            }
            // Animate image
            imageView.alpha = 0.0
            UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
                self.imageView.layer.opacity = 1.0
                }.startAnimation()
        }
    }
    
    /**
     Perform data binding for this view and the given model.
     
     - parameters:
       - recipe: Recipe to be displayed.
     */
    func dataBind(with recipe: DetailedRecipe) {
        // Download and display the image
        imageURL = recipe.imageURL
        if let url = URL(string: recipe.imageURL) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    self.image = image
                }
            }
        }
        
        // Display ingridients
        viewModel = IngridientsViewModel(recipe.ingredients)
        ingridientsView.dataSource = viewModel
        ingridientsView.setNeedsLayout()
        
        // Display the rest
        name = recipe.name
        prepTextView.text = recipe.prepTime
        cookTextView.text = recipe.cookTime
        servesTextView.text = "\(recipe.numberOfServings) adults"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation buttons
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        unsaveButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(unsaveButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        print("Display recipe id: \(recipeId ?? "None")")

        // Set the default button
        navigationItem.rightBarButtonItem = recipeId != nil && ServiceProvider.savedRecipeService.isSaved(recipeId!) ? unsaveButton : saveButton
        
        guard recipeId != nil else {
            return
        }
        
        activityIndicatorView.startAnimating()
        ServiceProvider.apiService.getRecipe(id: recipeId!) {
            recipe in DispatchQueue.main.async {
                self.dataBind(with: recipe)
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        // Resize the ingridients list to fit content
        ingridientsViewHeightConstraint.constant = ingridientsView.contentSize.height
    }
    
    @objc func saveButtonTapped() {
        guard recipeId != nil && name != nil && imageURL != nil else {
            return
        }
        
        let recipe = SavedRecipe(id: recipeId!, name: name!, imageURL: imageURL!)!
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
