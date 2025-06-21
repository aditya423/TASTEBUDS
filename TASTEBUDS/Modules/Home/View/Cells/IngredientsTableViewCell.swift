//
//  IngredientsTableViewCell.swift
//  TASTEBUDS
//
//  Created by Aditya on 21/06/25.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var ingredientTitleLbl: UILabel!
    @IBOutlet weak var ingredientWeightLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        parentView.layer.cornerRadius = 15
        parentView.setShadow()
    }
    
    func setupCell(name: String?, weight: String?) {
        ingredientTitleLbl.text = name
        ingredientWeightLbl.text = weight
    }
}
