//
//  IngridientsViewModel.swift
//  FoodAppUnitTests
//
//  Created by Iaroslav Khrypko on 22/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import XCTest
@testable import FoodApp

class IngridientsViewModelTests: XCTestCase {
    func testInit() {
        // Arrange
        let ingridients: [String] = ["100g chorizo"]
        
        // Act
        _ = IngridientsViewModel(ingridients)
        
        // Assert
        XCTAssertTrue(true) // Doesn't throw
    }
    
    func testNumRows() {
        // Arrange
        let ingridients: [String] = ["100g chorizo"]
        let viewModel = IngridientsViewModel(ingridients)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel
        
        // Act
        let numRows = tableView.numberOfRows(inSection: 0)
        
        // Assert
        XCTAssertEqual(ingridients.count, numRows)
    }
    
    func testNumRowsNoData() {
        // Arrange
        let ingridients: [String] = []
        let viewModel = IngridientsViewModel(ingridients)
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel
        
        // Act
        let numRows = tableView.numberOfRows(inSection: 0)
        
        // Assert
        XCTAssertEqual(ingridients.count, numRows)
    }
    
    func testCellCreation() {
        // Arrange
        let ingridients: [String] = ["100g chorizo"]
        let viewModel = IngridientsViewModel(ingridients)

        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tableView = UITableView(frame: frame)
        tableView.dataSource = viewModel
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellTemplate")
        
        // Act
        let cell = viewModel.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // Assert
        XCTAssertNotNil(cell.textLabel)
        XCTAssertNotNil(cell.textLabel!.text)
        XCTAssertEqual(ingridients[0], cell.textLabel!.text!)
    }
}
