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
    
    override func resume() {
        // resume is empty so that it doesnt do any of the network call and controll the mocksession ourself
    }
}

final class URLMockSession: URLSession {
    let error: Error?
    let data: Data?
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    override func dataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(self.data, nil, self.error)
        return MockDataTask()
    }
}

