//
//  APIServiceTests.swift
//  SharedTests
//
//  Created by DongHeeKang on 25/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import XCTest
@testable import Shared

import Foundation

final class MockService: APIService {
    
    // MARK: - Properties
    
    var session: URLSession {
        return URLSession.shared
    }
    var scheme: String {
        return "https"
    }
    var host: String {
        return "api.github.com"
    }
    
}

class APIServiceTests: XCTestCase {
    
    // MARK: - Properties
    
    let service = MockService()
    
    // MARK: - Tests
    
    func testParse() {
        // Given
        let data = """
        {
            "fuels": [
                {
                    "type": "100LL",
                    "price": 2.54
                },
                {
                    "type": "Jet A",
                    "price": 3.14,
                },
                {
                    "type": "Jet B",
                    "price": 3.03
                }
            ]
        }
        """.data(using: .utf8)!
        
        enum Fuel: String, Decodable {
            case jetA = "Jet A"
            case jetB = "Jet B"
            case oneHundredLowLead = "100LL"
        }
        struct CanadianFuelPrice: Decodable {
            public let type: Fuel
            public let price: Double
        }
        
        // When
        var model: [String: [CanadianFuelPrice]]? = nil
        var fuels: [CanadianFuelPrice]? = nil
        do {
            model = try service.parse([String: [CanadianFuelPrice]].self, data: data)
            fuels = model?["fuels"]
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        // Then
        XCTAssertNotNil(model)
        XCTAssertNotNil(fuels)
        
        XCTAssertEqual(fuels?.count, 3)
        
        XCTAssertEqual(fuels?[0].type, Fuel.oneHundredLowLead)
        XCTAssertEqual(fuels?[0].price, 2.54)
        
        XCTAssertEqual(fuels?[1].type, Fuel.jetA)
        XCTAssertEqual(fuels?[1].price, 3.14)
        
        XCTAssertEqual(fuels?[2].type, Fuel.jetB)
        XCTAssertEqual(fuels?[2].price, 3.03)
    }
    
    func testGetRequest() {
        // Given
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "q", value: "swift"))
        let request: URLRequest?
        
        // When
        request = service.getRequest(.get, path: "/search/repositories", queryItems: queryItems)
        
        // Then
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.httpMethod, HTTPMethod.get.rawValue)
        XCTAssertEqual(request?.url?.absoluteString, "https://api.github.com/search/repositories?q=swift")
    }
    
    func testDataTask() {
        // Given
        let expectation = self.expectation(description: "testDataTask")
        let modelType = SearchRepositoriesModel.self
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "q", value: "swift"))
        var result: Result<SearchRepositoriesModel>!
        
        // When
        service.dataTask(modelType, httpMethod: .get, path: "/search/repositories", queryItems: queryItems) { (response) in
            result = response
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
        
        // Then
        XCTAssertTrue(result.isSuccess)
    }
    
}
