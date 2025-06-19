//
//  HomeViewController.swift
//  TASTEBUDS
//
//  Created by Aditya on 17/06/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var mealsTableView: UITableView!
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupTableView()
        getMealsData()
    }
    
    func setupTableView() {
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        let cellNib = UINib(nibName: FileNames.recipeTableViewCell.rawValue, bundle: nil)
        mealsTableView.register(cellNib, forCellReuseIdentifier: FileNames.recipeTableViewCell.rawValue)
    }
    
    private func getMealsData() {
        showLoader()
        viewModel.getMealsFromService { [weak self] success, error in
            DispatchQueue.main.async {
                hideLoader()
                guard let self = self else { return }
                if success != nil {
                    self.mealsTableView.reloadData()
                } else {
                    self.showAlert(title: ErrorTitles.error.rawValue, message: error?.localizedDescription ?? ErrorDesc.noDataFound.rawValue)
                }
            }
        }
    }
}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealsTableView.dequeueReusableCell(withIdentifier: FileNames.recipeTableViewCell.rawValue, for: indexPath) as? RecipeTableViewCell
        cell?.setupCell(mealData: viewModel.meals?[indexPath.row])
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
