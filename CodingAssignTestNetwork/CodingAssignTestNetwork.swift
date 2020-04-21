//
//  CodingAssignTestNetwork.swift
//  CodingAssignTestNetwork
//
//  Created by Ruoming Gao on 4/16/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import XCTest
@testable import CodingAssign

class CodingAssignTestNetwork: XCTestCase {

    var sut: NetworkController!
    let validURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    struct TestModel: Codable {
        let name: String
        let id: Int
    }
    
    func testLoadData() {
        let session = URLMockSession(data: nil, error: nil)
        sut = NetworkController(session: session)
        
        sut.getData( url: validURL) { (data: Data?, error) in
            XCTAssertNil(data)
            let networkerror = error as? NetworkError
            XCTAssertTrue(networkerror == NetworkError.noData)
        }
    }
    
    func testInvalidURL() {
        let session = URLMockSession(data: nil, error: nil)
        sut = NetworkController(session: session)
        sut.getData(url: "") { (_: Data?, error) in
            let networkerror = error as? NetworkError
            XCTAssertTrue(networkerror == NetworkError.invalidURL)
        }
    }

    func testInvalidJsonData() {
        let jsonObject: [String: String] = [
            "firstName": "fail",
            "lastName": "failure",
            "id": "9"
        ]
        let exp = expectation(description: "wait for network")
        let jsonEncoder = try? JSONEncoder().encode(jsonObject)
        let session = URLMockSession(data: jsonEncoder, error: nil)
        sut = NetworkController(session: session)
        sut.getData(url: validURL) { (data: TestModel?, error) in
            exp.fulfill()
            XCTAssertNil(data)
            let networkError = error as? NetworkError
            XCTAssertEqual(networkError, NetworkError.invalidJSONData)
        }
        waitForExpectations(timeout: 0.5, handler: nil)
    }

    func testValidData() {
        let jsonencoder = JSONEncoder()
        let jsonData = try? jsonencoder.encode(TestModel(name: "Jerry", id: 132))
        let session = URLMockSession(data: jsonData, error: nil)
        sut = NetworkController(session: session)
        sut.getData(url: validURL) { (data: TestModel?, error) in
            XCTAssertEqual(data?.name, "Jerry")
            XCTAssertNil(error)
        }
    }

    func testUnknownError() {
        let unknownErrorSession = URLMockSession(data: nil, error: NetworkError.unknown)
        sut = NetworkController(session: unknownErrorSession)
        let exp = expectation(description: "wait for network")
        sut.getData(url: validURL) { (data: TestModel?, error) in
            XCTAssertNil(data)
            let networkError = error as? NetworkError
            XCTAssertEqual(networkError, NetworkError.unknown)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testPostUnknowError() {
        let session = URLMockSession(data: nil, error: NetworkError.unknown)
        sut = NetworkController(session: session)
        let exp = expectation(description: "wait for network")
        sut.postData(url: validURL, headers: [:], data: nil) { (data, error) in
            XCTAssertNil(data)
            let networkError = error as? NetworkError
            XCTAssertEqual(networkError, NetworkError.unknown)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testPostInvalidURL() {
        let session = URLMockSession(data: nil, error: nil)
        sut = NetworkController(session: session)
        sut.postData(url: "", headers: [:], data: nil) { (data, error) in
            let networkerror = error as? NetworkError
            XCTAssertTrue(networkerror == NetworkError.invalidURL)
        }
    }
    
    func testPostValidData() {
        let jsonencoder = JSONEncoder()
        let jsonData = try? jsonencoder.encode(TestModel(name: "Jerry", id: 132))
        let session = URLMockSession(data: jsonData, error: nil)
        sut = NetworkController(session: session)
        let data = Data(jsonData!)
        sut.postData(url: validURL, headers: [:], data: data) { (data, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
        }
    }
}
