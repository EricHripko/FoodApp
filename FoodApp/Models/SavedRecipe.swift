//
//  SavedRecipe.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

/**
 Saved recipe that can be persisted on the file system.
 */
class SavedRecipe: NSObject, NSCoding {
    /**
     Unique identifier for the recipe.
     */
    var id: String
    
    /**
     Name of the recipe.
     */
    var name: String
    
    /**
     Image for the recipe.
     */
    var imageURL: String
    
    /**
     Create a new saved recipe.
     
     - parameters:
       - id: Unique identifier.
       - name: Name.
       - imageURL: URL for the recipe image.
     */
    init?(id: String, name: String, imageURL: String) {
        guard !id.isEmpty else {
            return nil
        }
        guard !name.isEmpty else {
            return nil
        }
        guard !imageURL.isEmpty else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
    
    /**
     Struct that holds names of all properties.
     */
    private struct PropertyKey {
        static let id = "id"
        static let name = "name"
        static let imageURL = "imageURL"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(imageURL, forKey: PropertyKey.imageURL)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? String else {
            return nil
        }
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            return nil
        }
        guard let imageURL = aDecoder.decodeObject(forKey: PropertyKey.imageURL) as? String else {
            return nil
        }
        
        self.init(id: id, name: name, imageURL: imageURL)
    }
}
