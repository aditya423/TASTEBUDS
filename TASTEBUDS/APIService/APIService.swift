//
//  APIService.swift
//  TASTEBUDS
//
//  Created by Aditya on 19/06/25.
//

import Foundation

let BASE_URL = "https://www.themealdb.com"

typealias stringAnyDict = [String: Any]
typealias stringStringDict = [String: String]
let contentKey = "Content-Type"
let contentValue = "application/x-www-form-urlencoded"

enum APIServices {
    case getMeals
}

extension APIServices {
    var path: String {
        let apiDomain = "/api/"
        var servicePath: String = ""
        switch self {
        case .getMeals: servicePath = apiDomain + "json/v2/1/randomselection.php"
            return BASE_URL + servicePath
        }
    }
}
