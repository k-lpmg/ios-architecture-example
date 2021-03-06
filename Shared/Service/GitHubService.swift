//
//  GitHubService.swift
//  ios-architecture-example
//
//  Created by DongHeeKang on 06/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import Foundation

final class GitHubService: APIService {
    
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
    
    // MARK: - Internal methods
    
    @discardableResult
    func searchRepositories(query: String, completion: @escaping (Result<SearchRepositoriesModel>) -> Void) -> URLSessionTask? {
        let queryItems = [URLQueryItem(name: "q", value: query)]
        return dataTask(SearchRepositoriesModel.self, path: "/search/repositories", queryItems: queryItems, completion: { (response) in
            completion(response)
        })
    }

}
