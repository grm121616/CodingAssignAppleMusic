//
//  NetworkError.swift
//  CodingAssign
//
//  Created by Ruoming Gao on 4/16/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unknown
    case noData
    case invalidJSONData
}
