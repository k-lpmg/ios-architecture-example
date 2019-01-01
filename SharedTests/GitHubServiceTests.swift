//
//  GitHubServiceTests.swift
//  SharedTests
//
//  Created by DongHeeKang on 01/01/2019.
//  Copyright © 2019 k-lpmg. All rights reserved.
//

import XCTest
@testable import Shared

import Foundation

class GitHubServiceTests: XCTestCase {
    
    let service = GitHubService()
    
    // MARK: - Tests
    
    func testSearchRepositories() {
        // Given
        let expectation = self.expectation(description: "testSearchRepositories")
        var result: Result<SearchRepositoriesModel>!
        
        // When
        service.searchRepositories(query: "swift") { (response) in
            result = response
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
        
        // Then
        XCTAssertTrue(result.isSuccess)
        XCTAssertNil(result.error)
    }
    
}
