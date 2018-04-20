//
//  RecipeTableViewCell.swift
//  FoodApp
//
//  Created by Iaroslav Khrypko on 20/04/2018.
//  Copyright © 2018 Armadillo. All rights reserved.
//

import UIKit

/**
 View that displays a recipe in the list of recipes for a user to pick from.
 */
@IBDesignable
class RecipeTableViewCell : UITableViewCell {
    @IBOutlet var view: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var textView: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconView.layer.cornerRadius = iconView.frame.width / 2
    }
    
    private func nibSetup() {
        backgroundColor = .clear
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let typeOf = type(of: self)
        let bundle = Bundle(for: typeOf)
        let nib = UINib(nibName: String(describing: typeOf), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
    
}
