//
//  SearchController_MVVM_Delegate.swift
//  ios-architecture-example
//
//  Created by DongHeeKang on 06/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import UIKit

final class SearchController_MVVM_Delegate: UIViewController {
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties()
    }
    
    // MARK: - Private methods
    
    private func setProperties() {
        title = "MVVM_Delegate"
    }
    
}
