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
    
    func dataTask<T>(_ modelType: T.Type,
                     httpMethod: HTTPMethod,
                     path: String?,
                     queryItems: [URLQueryItem]?,
                     completion: ((Result<T>) -> Void)?) -> URLSessionTask? where T: Decodable
}

extension APIService {
    
    @discardableResult
    func dataTask<T>(_ modelType: T.Type,
                     httpMethod: HTTPMethod = .get,
                     path: String? = nil,
                     queryItems: [URLQueryItem]? = nil,
                     completion: ((Result<T>) -> Void)? = nil) -> URLSessionTask? where T: Decodable {
        guard let request = getRequest(httpMethod, path: path, queryItems: queryItems) else {
            completion?(Result.error(APIError.urlIsInvalid))
            return nil
        }
        
        let task = session.dataTask(with: request) { (data, _, error) in
            let result: Result<T>
            defer {
                DispatchQueue.main.async {
                    completion?(result)
                }
            }
            
            guard let data = data else {
                result = Result.error(APIError.dataIsNil)
                return
            }
            guard let error = error else {
                do {
                    result = Result.value(try self.parse(modelType, data: data))
                } catch {
                    result = Result.error(error)
                }
                return
            }
            
            result = Result.error(error)
        }
        task.resume()
        return task
    }
    
    func getRequest(_ httpMethod: HTTPMethod, path: String?, queryItems: [URLQueryItem]?) -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path ?? ""
        components.queryItems = queryItems
        
        guard let url = components.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
    func parse<T>(_ modelType: T.Type, data: Data) throws -> T where T: Decodable {
        return try JSONDecoder().decode(modelType, from: data)
    }
    
}
