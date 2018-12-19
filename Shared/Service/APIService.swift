//
//  APIService.swift
//  ios-architecture-example
//
//  Created by DongHeeKang on 06/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import Foundation

protocol APIService {
    var session: URLSession { get }
    var scheme: String { get }
    var host: String { get }
    
    func dataTask(_ httpMethod: HTTPMethod, path: String?, queryItems: [URLQueryItem]?, completion: ((Result<(Data?, URLResponse?)>) -> Void)?) -> URLSessionTask
}

extension APIService {
    
    @discardableResult
    func dataTask(_ httpMethod: HTTPMethod = .get, path: String? = nil, queryItems: [URLQueryItem]? = nil, completion: ((Result<(Data?, URLResponse?)>) -> Void)? = nil) -> URLSessionTask {
        let request = getRequest(httpMethod, path: path, queryItems: queryItems)
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            let result: Result<(Data?, URLResponse?)>
            defer {
                DispatchQueue.main.async {
                    completion?(result)
                }
            }
            
            guard let error = error else {
                result = Result.value((data, urlResponse))
                return
            }
            
            result = Result.error(error)
        }
        
        task.resume()
        return task
    }
    
    private func getRequest(_ httpMethod: HTTPMethod, path: String?, queryItems: [URLQueryItem]?) -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path ?? ""
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
}
