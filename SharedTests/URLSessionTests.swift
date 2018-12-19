//
//  URLSessionTests.swift
//  SharedTests
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import XCTest
@testable import Shared

import Foundation

class URLSessionTests: XCTestCase {
    
    // MARK: - Tests
    
    func testDataTask() {
        // Given
        let expectation = self.expectation(description: "testDataTask")
        guard let url = baseUrlComponents.url else {
            XCTFail("baseUrlComponents.url is nil")
            return
        }
        var response: (Data?, URLResponse?, Error?)
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        // When
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            response = (data, urlResponse, error)
            expectation.fulfill()
        }
        task.resume()
        wait(for: [expectation], timeout: 30)
        
        // Then
        XCTAssertNotNil(response.0)
        XCTAssertNotNil(response.1)
        XCTAssertNil(response.2)
    }
    
}
