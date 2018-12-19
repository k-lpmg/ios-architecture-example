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
    
    // MARK: - Tests
    
    func testHttpMethod() {
        // Given
        guard let url = baseUrlComponents.url else {
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
