//
//  HomeViewModel.swift
//  TASTEBUDS
//
//  Created by Aditya on 17/06/25.
//

import Foundation

class HomeViewModel {
    
    var meals: [Meals]?
    
    func getMealsFromService(completion: @escaping (RestaurantModel?, Error?) -> (Void)) {
        MealService.getMeals() { response, error in
            if response != nil {
                self.meals = response?.meals
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
