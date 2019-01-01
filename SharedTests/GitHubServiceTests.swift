//
//  GitHubServiceTests.swift
//  SharedTests
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
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
