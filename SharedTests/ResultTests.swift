//
//  ResultTests.swift
//  SharedTests
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import XCTest
@testable import Shared

import Foundation

class ResultTests: XCTestCase {
    
    enum MockError: Error {
        case testError
    }
    
    // MARK: - Tests
    
    func testValue() {
        // Given
        let value = "testValue"
        let result: Result<String>
        
        // When
        result = Result.value(value)
        
        // Then
        XCTAssertEqual(result.value, value)
        XCTAssertTrue(result.isSuccess)
    }
    
    func testError() {
        // Given
        let error = MockError.testError
        let result: Result<String>
        
        // When
        result = Result.error(error)
        
        // Then
        XCTAssertEqual(result.error as? MockError, error)
        XCTAssertTrue(result.isFailure)
    }
    
}
