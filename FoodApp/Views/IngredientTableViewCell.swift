//
//  IngredientTableViewCell.swift
//  FoodApp
//
//  Created by Dominykas Brezgys on 18/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var ingredientButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
