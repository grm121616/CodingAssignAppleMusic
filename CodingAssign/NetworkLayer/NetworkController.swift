//
//  NetworkController.swift
//  CodingAssign
//
//  Created by Ruoming Gao on 4/16/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

class NetworkController {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getData<T: Codable>(url: String, completionHandler: @escaping ((T?, Error?) -> Void)) {
        guard let url = URL(string: url) else {
            completionHandler(nil, NetworkError.invalidURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            guard let data = data else {
                completionHandler(nil, NetworkError.noData)
                return
            }
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(nil, NetworkError.invalidJSONData)
                return
            }
            completionHandler(decodedData, nil)
        }
        task.resume()
    }
    
    func postData(url: String, headers: [String: String], data: Data?, completion: @escaping (Data?, Error?) -> ()) {
        guard let url = URL(string: url) else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.allHTTPHeaderFields = headers
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
            }
            
            if let data = data {
                completion(data, nil)
            }
        }.resume()
    }
}
