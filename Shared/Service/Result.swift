//
//  Result.swift
//  ios-architecture-example
//
//  Created by DongHeeKang on 06/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import Foundation

enum Result<Value> {
    case value(Value)
    case error(Error)
    
    var isSuccess: Bool {
        switch self {
        case .value:
            return true
        case .error:
            return false
        }
    }
    
    var isFailure: Bool {
        return !isSuccess
    }
    
    var value: Value? {
        switch self {
        case .value(let value):
            return value
        case .error:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .value:
            return nil
        case .error(let error):
            return error
        }
    }
}
