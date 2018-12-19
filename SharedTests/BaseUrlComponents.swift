//
//  BaseUrlComponents.swift
//  SharedTests
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import Foundation

var baseUrlComponents: URLComponents {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.github.com"
    return components
}
