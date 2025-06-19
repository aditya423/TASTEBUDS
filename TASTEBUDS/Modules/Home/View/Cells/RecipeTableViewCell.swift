//
//  RecipeTableViewCell.swift
//  TASTEBUDS
//
//  Created by Aditya on 19/06/25.
//

import UIKit
import SDWebImage
import Kingfisher

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var viewMoreBtn: UIButton!
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(mealData: Meals?) {
        if let url = URL(string: mealData?.strMealThumb ?? "") {
            mealImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
        titleLbl.text = mealData?.strMeal
        descLbl.text = mealData?.strInstructions
    }
    
    @IBAction func viewMoreBtnTapped(_ sender: UIButton) {}
}
