//
//  SavedRecipeViewModelTests.swift
//  FoodAppUnitTests
//
//  Created by Iaroslav Khrypko on 22/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import XCTest
@testable import FoodApp

class SavedRecipeViewModelTests: XCTestCase {
    func testInit() {
        // Arrange
        let recipes: [SavedRecipe] = [SavedRecipe(id: "abcdef", name: "Paella", imageURL: "http://via.placeholder.com/350x150")!]
        
        // Act
        _ = SavedRecipesViewModel(with: recipes)
        
        // Assert
        XCTAssertTrue(true) // Doesn't throw
    }

    func testNoData() {
        // Arrange
        let recipes: [SavedRecipe] = []
        let viewModel = SavedRecipesViewModel(with: recipes)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        
        // Act
        _ = viewModel.numberOfSections(in: tableView)
        
        // Assert
        XCTAssertNotNil(tableView.backgroundView)
        
        let label = tableView.backgroundView as? UILabel
        XCTAssertNotNil(label)
        XCTAssertEqual("Saved recipes are added here", label!.text)
        XCTAssertEqual(UITableViewCellSeparatorStyle.none, tableView.separatorStyle)
    }

    func testCanEditRow() {
        // Arrange
        let recipes: [SavedRecipe] = [SavedRecipe(id: "abcdef", name: "Paella", imageURL: "http://via.placeholder.com/350x150")!]
        let viewModel = SavedRecipesViewModel(with: recipes)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        
        // Act
        let canEditRow = viewModel.tableView(tableView, canEditRowAt: IndexPath(row: 0, section: 0))
        
        // Assert
        XCTAssertTrue(canEditRow)
    }
    
    func testCommitNoChanges() {
        // Arrange
        let recipes: [SavedRecipe] = [SavedRecipe(id: "abcdef", name: "Paella", imageURL: "http://via.placeholder.com/350x150")!]
        let viewModel = SavedRecipesViewModel(with: recipes)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        
        // Act
        viewModel.tableView(tableView, commit: .none, forRowAt: IndexPath(row: 0, section: 0))
        
        // Assert
        XCTAssertTrue(true) // Doesn't throw
    }
    
    func testCommitInsertChanges() {
        // Arrange
        let recipes: [SavedRecipe] = [SavedRecipe(id: "abcdef", name: "Paella", imageURL: "http://via.placeholder.com/350x150")!]
        let viewModel = SavedRecipesViewModel(with: recipes)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        
        // Act
        viewModel.tableView(tableView, commit: .insert, forRowAt: IndexPath(row: 0, section: 0))
        
        // Assert
        XCTAssertTrue(true) // Doesn't throw
    }
    
    func testCommitDeleteChanges() {
        // Arrange
        let recipes: [SavedRecipe] = [SavedRecipe(id: "abcdef", name: "Paella", imageURL: "http://via.placeholder.com/350x150")!]
        let viewModel = SavedRecipesViewModel(with: recipes)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel
        
        // Act
        viewModel.tableView(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        // Assert
        XCTAssertEqual(0, tableView.numberOfRows(inSection: 0))
    }
}
