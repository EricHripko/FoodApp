//
//  IngridientsViewModel.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 17/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

/**
 View model for displaying a list of ingridients.
 */
class IngridientsViewModel : NSObject, UITableViewDataSource {
    /**
     Ingridients to be displayed.
     */
    private let ingridients: [String]
    
    /**
     Create a new view model for displaying ingridients.
     
     - parameters:
       - ingridients: Ingridients.
     */
    init(_ ingridients: [String]) {
        self.ingridients = ingridients;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingridients.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTemplate")!

        let ingridient = self.ingridients[indexPath.row]
        cell.textLabel?.text = ingridient
        
        return cell;
    }
}
