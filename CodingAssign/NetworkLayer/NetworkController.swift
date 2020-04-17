//
//  NetworkController.swift
//  CodingAssign
//
//  Created by Ruoming Gao on 4/16/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

class NetworkController {
    func getData<T: Codable>(session: URLSession, url: String, completionHandler: ((T?, Error?) -> Void)?) {
        guard let url = URL(string: url) else {
            completionHandler?(nil, NetworkError.invalidURL)
            return
        }
        session.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler?(nil, error)
                return
            }
            guard let data = data else {
                completionHandler?(nil, NetworkError.noData)
                return
            }
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler?(nil, NetworkError.invalidJSONData)
                return
            }
            completionHandler?(decodedData, nil)
        }.resume()
    }
}
