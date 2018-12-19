//
//  URLComponentsTests.swift
//  SharedTests
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import XCTest
@testable import Shared

import Foundation

class URLComponentsTests: XCTestCase {
    
    // MARK: - Properties
    
    let baseUrl = "https://api.github.com"
    
    // MARK: - Tests
    
    func testSchemeAndHost() {
        // Given
        let components = baseUrlComponents
        
        // Then
        componentsCompare(components: components, string: baseUrl)
    }
    
    func testPath() {
        // Given
        var components = baseUrlComponents
        
        // When
        components.path = "/search/repositories"
        
        // Then
        componentsCompare(components: components, string: baseUrl.appending("/search/repositories"))
    }
    
    func testQueryItem() {
        // Given
        var components = baseUrlComponents
        
        // When
        components.queryItems = [URLQueryItem(name: "q", value: "swift")]
        
        // Then
        componentsCompare(components: components, string: baseUrl.appending("?q=swift"))
    }
    
    // MARK: - Private methods
    
    private func componentsCompare(components: URLComponents, string: String) {
        XCTAssertEqual(components.string, string)
        XCTAssertEqual(components.description, string)
        XCTAssertEqual(components.url?.absoluteString, string)
        XCTAssertEqual(components.url?.relativeString, string)
    }
    
}
