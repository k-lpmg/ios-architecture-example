//
//  GithubSearchRepositoriesAPITests.swift
//  SharedTests
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import XCTest
@testable import Shared

import Foundation

class GithubSearchRepositoriesAPITests: XCTestCase {
    
    struct GithubAPIModel: Decodable {
        var current_user_url: String
        var current_user_authorizations_html_url: String
        var authorizations_url: String
        var code_search_url: String
        var commit_search_url: String
        var emails_url: String
        var emojis_url: String
        var events_url: String
        var feeds_url: String
        var followers_url: String
        var following_url: String
        var gists_url: String
        var hub_url: String
        var issue_search_url: String
        var issues_url: String
        var keys_url: String
        var notifications_url: String
        var organization_repositories_url: String
        var organization_url: String
        var public_gists_url: String
        var rate_limit_url: String
        var repository_url: String
        var repository_search_url: String
        var current_user_repositories_url: String
        var starred_url: String
        var starred_gists_url: String
        var team_url: String
        var user_url: String
        var user_organizations_url: String
        var user_repositories_url: String
        var user_search_url: String
    }
    
    let api = GithubSearchRepositoriesAPI()
    
    // MARK: - Tests
    
    func testDataTask() {
        // Given
        let expectation = self.expectation(description: "testDataTask")
        var result: Result<(Data?, URLResponse?)>!
        
        // When
        api.dataTask { (response) in
            result = response
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
        
        // Then
        XCTAssertNotNil(result.value)
        XCTAssertTrue(result.isSuccess)
        XCTAssertNotNil(result.value?.0)
        XCTAssertNotNil(result.value?.1)
        XCTAssertNil(result.error)
    }
    
    func testJSONDecoder() {
        // Given
        let expectation = self.expectation(description: "testDataTask")
        let jsonDecoder = JSONDecoder()
        var result: Result<GithubAPIModel>!
        
        // When
        api.dataTask { (response) in
            guard let data = response.value?.0 else {
                XCTFail("response data is nil")
                return
            }
            do {
                let model = try jsonDecoder.decode(GithubAPIModel.self, from: data)
                result = Result.value(model)
            } catch {
                result = Result.error(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
        
        // Then
        XCTAssertTrue(result.isSuccess)
        XCTAssertNil(result.error)
    }
    
    func testSearchRepositories() {
        // Given
        let expectation = self.expectation(description: "testSearchRepositories")
        var result: Result<SearchRepositoriesModel>!
        
        // When
        api.searchRepositories(query: "swift") { (response) in
            result = response
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
        
        // Then
        XCTAssertTrue(result.isSuccess)
        XCTAssertNil(result.error)
    }
    
}
