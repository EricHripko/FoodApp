//
//  RecipeViewModelTests.swift
//  FoodAppUnitTests
//
//  Created by Iaroslav Khrypko on 22/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import XCTest
@testable import FoodApp

class RecipeViewModelTests: XCTestCase {
    func testInit() {
        // Arrange
        let recipes: [RecipeProtocol] = [Recipe(id: "abcdef", name: "Paella", smallImageURL: "http://via.placeholder.com/350x150")]
        let noData = "No data"
        
        // Act
        _ = RecipesViewModel(with: recipes, noData: noData)
        
        // Assert
        XCTAssertTrue(true) // Doesn't throw
    }
    
    func testNoData() {
        // Arrange
        let recipes: [RecipeProtocol] = []
        let noData = "No data"
        let viewModel = RecipesViewModel(with: recipes, noData: noData)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel

        // Act
        _ = tableView.numberOfSections
        
        // Assert
        XCTAssertNotNil(tableView.backgroundView)
        
        let label = tableView.backgroundView as? UILabel
        XCTAssertNotNil(label)
        XCTAssertEqual(noData, label!.text)
        XCTAssertEqual(UITableViewCellSeparatorStyle.none, tableView.separatorStyle)
    }
    
    func testDataExists() {
        // Arrange
        let recipes: [RecipeProtocol] = [Recipe(id: "abcdef", name: "Paella", smallImageURL: "http://via.placeholder.com/350x150")]
        let noData = "No data"
        let viewModel = RecipesViewModel(with: recipes, noData: noData)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel
        
        // Act
        _ = tableView.numberOfSections

        // Assert
        XCTAssertNil(tableView.backgroundView)
        XCTAssertEqual(UITableViewCellSeparatorStyle.singleLine, tableView.separatorStyle)
    }
    
    func testNumSections() {
        // Arrange
        let recipes: [RecipeProtocol] = [Recipe(id: "abcdef", name: "Paella", smallImageURL: "http://via.placeholder.com/350x150")]
        let noData = "No data"
        let viewModel = RecipesViewModel(with: recipes, noData: noData)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel

        // Act
        let numSections = tableView.numberOfSections
        
        // Assert
        XCTAssertEqual(1, numSections)
    }

    func testNumSectionsNoData() {
        // Arrange
        let recipes: [RecipeProtocol] = []
        let noData = "No data"
        let viewModel = RecipesViewModel(with: recipes, noData: noData)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel

        // Act
        let numSections = tableView.numberOfSections
        
        // Assert
        XCTAssertEqual(1, numSections)
    }

    func testCellCreation() {
        // Arrange
        let recipes: [RecipeProtocol] = [Recipe(id: "abcdef", name: "Paella", smallImageURL: "http://via.placeholder.com/350x150")]
        let noData = "No data"
        let viewModel = RecipesViewModel(with: recipes, noData: noData)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "cellTemplate")
        
        // Act
        let cell = viewModel.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // Assert
        let recipeCell = cell as? RecipeTableViewCell
        XCTAssertNotNil(recipeCell)
        XCTAssertNotNil(recipeCell!.name)
        XCTAssertEqual(recipes[0].name, recipeCell!.name!)
    }
    
    func testNumRows() {
        // Arrange
        let recipes: [RecipeProtocol] = [Recipe(id: "abcdef", name: "Paella", smallImageURL: "http://via.placeholder.com/350x150")]
        let noData = "No data"
        let viewModel = RecipesViewModel(with: recipes, noData: noData)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel

        // Act
        let numRows = tableView.numberOfRows(inSection: 0)
        
        // Assert
        XCTAssertEqual(recipes.count, numRows)
    }
    
    func testNumRowsNoData() {
        // Arrange
        let recipes: [RecipeProtocol] = []
        let noData = "No data"
        let viewModel = RecipesViewModel(with: recipes, noData: noData)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel

        // Act
        let numRows = tableView.numberOfRows(inSection: 0)
        
        // Assert
        XCTAssertEqual(recipes.count, numRows)
    }
    
    func testSelectedRecipe() {
        // Arrange
        let recipes: [RecipeProtocol] = [Recipe(id: "abcdef", name: "Paella", smallImageURL: "http://via.placeholder.com/350x150")]
        let noData = "No data"
        let viewModel = RecipesViewModel(with: recipes, noData: noData)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        
        // Act
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        let selectedRecipe = viewModel.selectedRecipe(for: tableView)
        
        // Assert
        XCTAssertNotNil(selectedRecipe)
        XCTAssertEqual(recipes[0].id, selectedRecipe!.id)
        XCTAssertEqual(recipes[0].name, selectedRecipe!.name)
        XCTAssertEqual(recipes[0].imageURL, selectedRecipe!.imageURL)
    }
    
    func testSelectedRecipeNoSelection() {
        // Arrange
        let recipes: [RecipeProtocol] = [Recipe(id: "abcdef", name: "Paella", smallImageURL: "http://via.placeholder.com/350x150")]
        let noData = "No data"
        let viewModel = RecipesViewModel(with: recipes, noData: noData)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        
        // Act
        let selectedRecipe = viewModel.selectedRecipe(for: tableView)
        
        // Assert
        XCTAssertNil(selectedRecipe)
    }
}
