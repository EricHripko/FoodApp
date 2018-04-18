//
//  FoodAppUnitTests.swift
//  FoodAppUnitTests
//
//  Created by Iaroslav Khrypko on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import Foundation
import XCTest
@testable import FoodApp

class SavedRecipeUnitTests: XCTestCase {
    
    func testInitSuccessful() {
        // Arrange
        let id = "abcdefgh"
        let name = "Paella"
        let imageURL = "http://via.placeholder.com/350x150"
        
        // Act
        let savedRecipe = SavedRecipe(id: id, name: name, imageURL: imageURL)
        
        // Assert
        XCTAssertNotNil(savedRecipe)
    }
    
    func testInitFailEmptyId() {
        // Arrange
        let id = ""
        let name = "Paella"
        let imageURL = "http://via.placeholder.com/350x150"
        
        // Act
        let savedRecipe = SavedRecipe(id: id, name: name, imageURL: imageURL)
        
        // Assert
        XCTAssertNil(savedRecipe)
    }
    
    func testInitFailEmptyName() {
        // Arrange
        let id = "abcdefgh"
        let name = ""
        let imageURL = "http://via.placeholder.com/350x150"
        
        // Act
        let savedRecipe = SavedRecipe(id: id, name: name, imageURL: imageURL)
        
        // Assert
        XCTAssertNil(savedRecipe)
    }
    
    func testInitFailEmptyImageURL() {
        // Arrange
        let id = "abcdefgh"
        let name = "Paella"
        let imageURL = ""
        
        // Act
        let savedRecipe = SavedRecipe(id: id, name: name, imageURL: imageURL)
        
        // Assert
        XCTAssertNil(savedRecipe)
    }
    
    func testEncode() {
        // Arrange
        let id = "abcdefgh"
        let name = "Paella"
        let imageURL = "http://via.placeholder.com/350x150"
        let savedRecipe = SavedRecipe(id: id, name: name, imageURL: imageURL)!
        
        let expected = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
\t<key>$archiver</key>
\t<string>NSKeyedArchiver</string>
\t<key>$objects</key>
\t<array>
\t\t<string>$null</string>
\t\t<dict>
\t\t\t<key>$class</key>
\t\t\t<dict>
\t\t\t\t<key>CF$UID</key>
\t\t\t\t<integer>5</integer>
\t\t\t</dict>
\t\t\t<key>id</key>
\t\t\t<dict>
\t\t\t\t<key>CF$UID</key>
\t\t\t\t<integer>2</integer>
\t\t\t</dict>
\t\t\t<key>imageURL</key>
\t\t\t<dict>
\t\t\t\t<key>CF$UID</key>
\t\t\t\t<integer>4</integer>
\t\t\t</dict>
\t\t\t<key>name</key>
\t\t\t<dict>
\t\t\t\t<key>CF$UID</key>
\t\t\t\t<integer>3</integer>
\t\t\t</dict>
\t\t</dict>
\t\t<string>abcdefgh</string>
\t\t<string>Paella</string>
\t\t<string>http://via.placeholder.com/350x150</string>
\t\t<dict>
\t\t\t<key>$classes</key>
\t\t\t<array>
\t\t\t\t<string>FoodApp.SavedRecipe</string>
\t\t\t\t<string>NSObject</string>
\t\t\t</array>
\t\t\t<key>$classname</key>
\t\t\t<string>FoodApp.SavedRecipe</string>
\t\t</dict>
\t</array>
\t<key>$top</key>
\t<dict>
\t\t<key>$0</key>
\t\t<dict>
\t\t\t<key>CF$UID</key>
\t\t\t<integer>1</integer>
\t\t</dict>
\t</dict>
\t<key>$version</key>
\t<integer>100000</integer>
</dict>
</plist>

"""
        
        let encodedData = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: encodedData)
        archiver.outputFormat = PropertyListSerialization.PropertyListFormat.xml
        
        // Act
        archiver.encodeRootObject(savedRecipe)
        archiver.finishEncoding()
        
        let actual = String(data: encodedData as Data, encoding: .utf8)!

        // Assert
        XCTAssertEqual(expected, actual)
    }
    
    func testDecode() {
        // Arrange
        let encoded = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
\t<key>$archiver</key>
\t<string>NSKeyedArchiver</string>
\t<key>$objects</key>
\t<array>
\t\t<string>$null</string>
\t\t<dict>
\t\t\t<key>$class</key>
\t\t\t<dict>
\t\t\t\t<key>CF$UID</key>
\t\t\t\t<integer>5</integer>
\t\t\t</dict>
\t\t\t<key>id</key>
\t\t\t<dict>
\t\t\t\t<key>CF$UID</key>
\t\t\t\t<integer>2</integer>
\t\t\t</dict>
\t\t\t<key>imageURL</key>
\t\t\t<dict>
\t\t\t\t<key>CF$UID</key>
\t\t\t\t<integer>4</integer>
\t\t\t</dict>
\t\t\t<key>name</key>
\t\t\t<dict>
\t\t\t\t<key>CF$UID</key>
\t\t\t\t<integer>3</integer>
\t\t\t</dict>
\t\t</dict>
\t\t<string>abcdefgh</string>
\t\t<string>Paella</string>
\t\t<string>http://via.placeholder.com/350x150</string>
\t\t<dict>
\t\t\t<key>$classes</key>
\t\t\t<array>
\t\t\t\t<string>FoodApp.SavedRecipe</string>
\t\t\t\t<string>NSObject</string>
\t\t\t</array>
\t\t\t<key>$classname</key>
\t\t\t<string>FoodApp.SavedRecipe</string>
\t\t</dict>
\t</array>
\t<key>$top</key>
\t<dict>
\t\t<key>$0</key>
\t\t<dict>
\t\t\t<key>CF$UID</key>
\t\t\t<integer>1</integer>
\t\t</dict>
\t</dict>
\t<key>$version</key>
\t<integer>100000</integer>
</dict>
</plist>

"""
        
        let encodedData = encoded.data(using: .utf8)!
        
        let unarchiver = NSKeyedUnarchiver(forReadingWith: encodedData)
        
        // Act
        let savedRecipe = unarchiver.decodeObject() as! SavedRecipe
        
        // Assert
        XCTAssertEqual("abcdefgh", savedRecipe.id)
        XCTAssertEqual("Paella", savedRecipe.name)
        XCTAssertEqual("http://via.placeholder.com/350x150", savedRecipe.imageURL)
    }
}
