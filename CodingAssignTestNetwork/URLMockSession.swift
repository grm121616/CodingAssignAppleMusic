//
//  URLMockSession.swift
//  CodingAssignTestNetwork
//
//  Created by Ruoming Gao on 4/16/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation
@testable import CodingAssign

final class MockDataTask: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        // resume is empty so that it doesnt do any of the network call and controll the mocksession ourself
    }
}

final class URLMockSession: URLSession {
    
    let error: Error?
    let data: Data?
    private (set) var lastURL: URL?
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        completionHandler(self.data, nil, self.error)
        return MockDataTask {
            completionHandler(data, nil, error)
        }
    }
}


