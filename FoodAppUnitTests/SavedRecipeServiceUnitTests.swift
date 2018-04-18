//
//  SavedRecipeServiceUnitTests.swift
//  FoodAppUnitTests
//
//  Created by Iaroslav Khrypko on 18/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import Foundation
import XCTest
@testable import FoodApp

class SavedRecipeServiceUnitTests: XCTestCase {
    func testInitWithRecipes() {
        // Arrange
        let recipes = [SavedRecipe(id: "abcdefgh", name: "Paella", imageURL: "http://via.placeholder.com/350x150")!]
        
        // Act
        let service = SavedRecipeService(with: recipes)
        
        // Assert
        XCTAssertEqual(service.recipes, recipes)
    }
    
    func testInitWithStorage() {
        // Arrange
        let recipes = [SavedRecipe(id: "abcdefgh", name: "Paella", imageURL: "http://via.placeholder.com/350x150")!]
        XCTAssertTrue(NSKeyedArchiver.archiveRootObject(recipes, toFile: SavedRecipeService.ArchiveURL.path))

        // Act
        let service = SavedRecipeService()
        
        // Assert
        XCTAssertEqual(service.recipes.count, recipes.count)
        XCTAssertEqual(service.recipes[0].id, recipes[0].id)
        XCTAssertEqual(service.recipes[0].name, recipes[0].name)
        XCTAssertEqual(service.recipes[0].imageURL, recipes[0].imageURL)
    }

    func testInitWithStorageNoRecipesSaved() {
        // Arrange
        try? FileManager.default.removeItem(at: SavedRecipeService.ArchiveURL)
        
        // Act
        _ = SavedRecipeService()
        
        // Assert
        XCTAssertTrue(true) // Doesn't throw
    }
    
    func testSave() {
        // Arrange
        let recipe = SavedRecipe(id: "abcdefgh", name: "Paella", imageURL: "http://via.placeholder.com/350x150")!
        let service = SavedRecipeService(with: [])
        
        // Act
        let result = service.save(recipe)
        
        // Assert
        XCTAssertTrue(result)
        XCTAssertTrue(service.recipes.contains(recipe))
    }
    
    func testUnsave() {
        // Arrange
        let recipeId = "abcdefgh"
        let recipes = [SavedRecipe(id: recipeId, name: "Paella", imageURL: "http://via.placeholder.com/350x150")!]
        let service = SavedRecipeService(with: recipes)
        
        // Act
        let result = service.unsave(recipeId)
        
        // Assert
        XCTAssertTrue(result)
        XCTAssertFalse(service.recipes.contains { $0.id == recipeId })
    }
    
    func testPersist() {
        // Arrange
        let recipes = [
            SavedRecipe(id: "abcdefgh", name: "Paella", imageURL: "http://via.placeholder.com/350x150")!,
            SavedRecipe(id: "hijklmop", name: "Risotto", imageURL: "http://via.placeholder.com/250x100")!
        ]
        let service = SavedRecipeService(with: recipes)
        
        // Act
        let result = service.persist()
        let anotherService = SavedRecipeService()

        // Assert
        XCTAssertTrue(result)
        XCTAssertEqual(recipes.count, anotherService.recipes.count)
        XCTAssertEqual(recipes[0].id, anotherService.recipes[0].id)
        XCTAssertEqual(recipes[0].name, anotherService.recipes[0].name)
        XCTAssertEqual(recipes[0].imageURL, anotherService.recipes[0].imageURL)
        XCTAssertEqual(recipes[1].id, anotherService.recipes[1].id)
        XCTAssertEqual(recipes[1].name, anotherService.recipes[1].name)
        XCTAssertEqual(recipes[1].imageURL, anotherService.recipes[1].imageURL)
    }
}
