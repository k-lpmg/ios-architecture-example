//
//  GithubSearchRepositoriesAPI.swift
//  ios-architecture-example
//
//  Created by DongHeeKang on 06/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import Foundation

final class GithubSearchRepositoriesAPI: APIService {
    
    // MARK: - Constants
    
    static let shared = GithubSearchRepositoriesAPI()
    
    // MARK: - Properties
    
    let jsonDecoder = JSONDecoder()
    var session: URLSession {
        return URLSession.shared
    }
    var scheme: String {
        return "https"
    }
    var host: String {
        return "api.github.com"
    }
    
    // MARK: - Public methods
    
    @discardableResult
    public func searchRepositories(query: String, completion: @escaping (Result<SearchRepositoriesModel>) -> Void) -> URLSessionTask {
        return GithubSearchRepositoriesAPI.shared.dataTask(path: "/search/repositories", queryItems: [URLQueryItem(name: "q", value: query)]) { (response) in
            let result: Result<SearchRepositoriesModel>
            defer {
                completion(result)
            }
            
            switch response {
            case .value(let value):
                guard let data = value.0 else {
                    result = Result.error(APIError.dataIsNil)
                    return
                }
                
                do {
                    let model = try self.jsonDecoder.decode(SearchRepositoriesModel.self, from: data)
                    result = Result.value(model)
                } catch {
                    result = Result.error(error)
                }
            case .error(let error):
                result = Result.error(error)
            }
        }
    }

}
