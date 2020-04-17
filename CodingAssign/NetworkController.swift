//
//  NetworkController.swift
//  CodingAssign
//
//  Created by Ruoming Gao on 4/16/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation


class NetworkController {
    func getData<T: Decodable>(session: Session = URLSession.shared, url: String, completionHandler: ((T?, Error?) -> Void)?) {
        guard let url = URL(string: url) else {
            completionHandler?(nil, NetworkError.invalidURL)
            return
        }
        session.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler?(nil, error) // general error for getting data
                return
            }
            guard let data = data else {
                completionHandler?(nil, NetworkError.noData) // Theres no Data
                return
            }
            guard let decodedData = try? ContextJSONDecoder().decode(T.self, from: data) else {
                completionHandler?(nil, NetworkError.invalidJSONData) // Invalid JSONData
                return
            }
            completionHandler?(decodedData, nil)
            }.resume()
    }
}
