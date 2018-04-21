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

class ApiResponseHandler: XCTestCase {
    func testInitSuccess() {
        let api = ApiResponseHandler()
        XCTAssertNotNil(api)
    }    
}
