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
    
    // MARK: - Constants
    
    private enum Const {
        static let url = "https://api.github.com"
    }
    
    // MARK: - Properties
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        return components
    }
    
    // MARK: - Tests
    
    func testSchemeAndHost() {
        componentsCompare(components: urlComponents, string: Const.url)
    }
    
    func testPath() {
        // Given
        var components = urlComponents
        
        // When
        components.path = "/search/repositories"
        
        // Then
        componentsCompare(components: components, string: Const.url.appending("/search/repositories"))
    }
    
    func testQueryItem() {
        // Given
        var components = urlComponents
        components.path = "/search/repositories"
        
        // When
        components.queryItems = [URLQueryItem(name: "q", value: "swift")]
        
        // Then
        componentsCompare(components: components, string: Const.url.appending("/search/repositories?q=swift"))
    }
    
    // MARK: - Private methods
    
    private func componentsCompare(components: URLComponents, string: String) {
        XCTAssertEqual(components.string, string)
        XCTAssertEqual(components.description, string)
        XCTAssertEqual(components.url?.absoluteString, string)
        XCTAssertEqual(components.url?.relativeString, string)
    }
    
}
