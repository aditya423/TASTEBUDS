//
//  APIManager.swift
//  TASTEBUDS
//
//  Created by Aditya on 19/06/25.
//

import Foundation

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    private override init() {}
    
    func makeApiCall(serviceType: APIServices, completion: @escaping (Result<Any, Error>) -> (Void)) {
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        let url = URL(string: serviceType.path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) {
            data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let content = data else {
                completion(.failure(error!))
                return
            }
            guard (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? stringAnyDict != nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(content))
        }
        task.resume()
    }
}
