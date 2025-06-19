//
//  MealService.swift
//  TASTEBUDS
//
//  Created by Aditya on 19/06/25.
//

import Foundation

class MealService {
    
    static func getMeals(completion: @escaping (RestaurantModel?, Error?) -> (Void)) {
        APIManager.sharedInstance.makeApiCall(serviceType: .getMeals) {
            response in
            switch response {
            case .success(let value):
                if let content = value as? Data {
                    do {
                        let responseData = try JSONDecoder().decode(RestaurantModel.self, from: content)
                        completion(responseData, nil)
                    }
                    catch {
                        completion(nil, value as? Error)
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
