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

extension HomeViewController: RecipeTableViewCellProtocol {
    func viewMoreAction(row: Int) {
        let vc = MealDetailsViewController.loadFromNib()
        vc.mealImageLink = viewModel.meals?[row].strMealThumb
        vc.mealName = viewModel.meals?[row].strMeal
        vc.mealDesc = viewModel.meals?[row].strInstructions
        vc.ingredientsData = viewModel.getIngredients(row: row)
        vc.youtubeLink = viewModel.meals?[row].strYoutube
        vc.modalPresentationStyle = .overFullScreen
        navigationController?.present(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealsTableView.dequeueReusableCell(withIdentifier: FileNames.recipeTableViewCell.rawValue, for: indexPath) as? RecipeTableViewCell
        cell?.setupCell(mealData: viewModel.meals?[indexPath.row])
        cell?.viewMoreBtn.tag = indexPath.row
        cell?.delegate = self
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        let label = UILabel()
        label.text = StringConstants.popularRecipes.rawValue
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5)
        ])
        return headerView
    }
}
