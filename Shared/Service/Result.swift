//
//  Result.swift
//  ios-architecture-example
//
//  Created by DongHeeKang on 06/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case value(Value)
    case error(Error)
    
    public var isSuccess: Bool {
        switch self {
        case .value:
            return true
        case .error:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: Value? {
        switch self {
        case .value(let value):
            return value
        case .error:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .value:
            return nil
        case .error(let error):
            return error
        }
    }
}
