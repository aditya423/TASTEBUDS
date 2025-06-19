//
//  HomeViewController.swift
//  TASTEBUDS
//
//  Created by Aditya on 17/06/25.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.sharedInstance.makeApiCall(serviceType: .getMeals) { response in
            print(response)
        }
    }
}
