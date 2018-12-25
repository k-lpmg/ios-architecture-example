//
//  URLRequestTests.swift
//  SharedTests
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import XCTest
@testable import Shared

import Foundation

class URLRequestTests: XCTestCase {
    
    // MARK: - Properties
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search/repositories"
        return components
    }
    
    // MARK: - Tests
    
    func testHttpMethod() {
        // Given
        guard let url = urlComponents.url else {
            XCTFail("baseUrlComponents.url is nil")
            return
        }
        var request = URLRequest(url: url)
        
        // When
        let httpMethod = HTTPMethod.delete
        request.httpMethod = httpMethod.rawValue
        
        // Then
        XCTAssertEqual(request.httpMethod, httpMethod.rawValue)
    }
    
}
