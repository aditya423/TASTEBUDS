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
    
    func getIngredients(row: Int) -> ([String], [String]) {
        var ingredients: [String] = []
        var weights: [String] = []
        if let meal = meals?[row] {
            let mirror = Mirror(reflecting: meal)
            for i in 1...20 {
                let key = "strIngredient\(i)"
                if let value = mirror.children.first(where: { $0.label == key })?.value as? String,
                   !value.trimmingCharacters(in: .whitespaces).isEmpty {
                    ingredients.append(value)
                }
            }
            for i in 1...20 {
                let key = "strMeasure\(i)"
                if let value = mirror.children.first(where: { $0.label == key })?.value as? String,
                   !value.trimmingCharacters(in: .whitespaces).isEmpty {
                    weights.append(value)
                }
            }
        }
        return (ingredients, weights)
    }
}
