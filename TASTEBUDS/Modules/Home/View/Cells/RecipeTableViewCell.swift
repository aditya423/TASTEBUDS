//
//  RecipeTableViewCell.swift
//  TASTEBUDS
//
//  Created by Aditya on 19/06/25.
//

import UIKit
import Kingfisher

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var viewMoreBtn: UIButton!
    @IBOutlet weak var likeImgView: UIImageView!
    weak var delegate: RecipeTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        mealImageView.layer.cornerRadius = 10
        likeImgView.layer.cornerRadius = 7
        parentView.layer.cornerRadius = 10
        parentView.setShadow()
        likeImgView.setShadow()
    }
    
    func setupCell(mealData: Meals?) {
        if let url = URL(string: mealData?.strMealThumb ?? "") {
            mealImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
        titleLbl.text = mealData?.strMeal
        descLbl.text = mealData?.strInstructions
    }
    
    @IBAction func viewMoreBtnTapped(_ sender: UIButton) {
        delegate?.viewMoreAction(row: sender.tag)
    }
}
