//
//  ApiResponseHandlerTests.swift
//  FoodAppUnitTests
//
//  Created by Boris Benchev on 21/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import Foundation
import XCTest
@testable import FoodApp

class ApiResponseHandlerTests: XCTestCase {
    func testInitSuccess() {
        let api = ApiResponseHandler()
        XCTAssertNotNil(api)
    }
    
    func testGetRecipesRealData() {
        let api = ApiResponseHandler()
        api.getRecipes(ingredients: ["Onion", "Chicken", "Rice"]) { (recipes) in
            XCTAssertEqual(recipes.count, 10)
        }
    }
    
    func testGetRecipesEmptyData() {
        let api = ApiResponseHandler()
        // Provide nonsense data
        api.getRecipes(ingredients: ["sdadadasdasd"]) { (recipes) in
            XCTAssertEqual(recipes.count, 1231)
        }
        
    }
}
