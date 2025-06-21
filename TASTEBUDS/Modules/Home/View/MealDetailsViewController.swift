//
//  MealDetailsViewController.swift
//  TASTEBUDS
//
//  Created by Aditya on 21/06/25.
//

import UIKit
import Kingfisher

class MealDetailsViewController: UIViewController {
    
    @IBOutlet weak var mealImgView: UIImageView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var hrView: UIView!
    @IBOutlet weak var mealTitleLbl: UILabel!
    @IBOutlet weak var mealDescLbl: UILabel!
    @IBOutlet weak var itemNoLbl: UILabel!
    @IBOutlet weak var ingredientsTblView: UITableView!
    @IBOutlet weak var ingredientsTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var likeBtn: UIImageView!
    @IBOutlet weak var itemCountLbl: UILabel!
    var mealImageLink: String?
    var mealName: String?
    var mealDesc: String?
    var ingredientsData: ([String], [String])?
    var youtubeLink: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ingredientsTblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        ingredientsTblView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ingredientsTblView.removeObserver(self, forKeyPath: "contentSize", context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey] {
                let newSize = newValue as! CGSize
                DispatchQueue.main.async {
                    self.ingredientsTblViewHeight.constant = newSize.height
                    self.view.setNeedsLayout()
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    private func setupUI() {
        if let url = URL(string: mealImageLink ?? "") {
            mealImgView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
        mealTitleLbl.text = mealName
        mealDescLbl.text = mealDesc
        itemCountLbl.text = "\(ingredientsData?.0.count ?? 0) Item"
        cancelBtn.layer.cornerRadius = 10
        likeBtn.layer.cornerRadius = 10
        parentView.layer.cornerRadius = 20
        parentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        parentView.clipsToBounds = true
        cancelBtn.setShadow()
        likeBtn.setShadow()
    }
    
    func setupTableView() {
        ingredientsTblView.delegate = self
        ingredientsTblView.dataSource = self
        let cellNib = UINib(nibName: FileNames.ingredientsTableViewCell.rawValue, bundle: nil)
        ingredientsTblView.register(cellNib, forCellReuseIdentifier: FileNames.ingredientsTableViewCell.rawValue)
        ingredientsTblView.reloadData()
    }
    
    static func loadFromNib() -> MealDetailsViewController {
        return MealDetailsViewController(nibName: FileNames.mealDetailsViewController.rawValue, bundle: nil)
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func footerButtonTapped() {
        if let url = URL(string: youtubeLink ?? ""), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            self.showAlert(title: ErrorTitles.error.rawValue, message: StringConstants.invalidURL.rawValue)
        }
    }
}

extension MealDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsData?.0.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientsTblView.dequeueReusableCell(withIdentifier: FileNames.ingredientsTableViewCell.rawValue, for: indexPath) as? IngredientsTableViewCell
        if let name = ingredientsData?.0[indexPath.row], let weight = ingredientsData?.1[indexPath.row] {
            cell?.setupCell(name: name, weight: weight)
        }
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        let button = UIButton(type: .system)
        button.setTitle(StringConstants.viewOnYoutube.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemTeal
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.layer.cornerRadius = 15
        button.setShadow()
        button.addTarget(self, action: #selector(footerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 5),
            button.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -5),
            button.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 15),
            button.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: 0)
        ])
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
}
