//
//  SearchView.swift
//  MVVM-Delegate
//
//  Created by DongHeeKang on 08/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import SafariServices
import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var viewModel: SearchViewModel = {
        return .init()
    }()
    private lazy var dataSource: SearchViewDataSource = {
        return .init(viewModel: self.viewModel)
    }()
    
    // MARK: - UI Components
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        layout()
        
        viewModel.delegate = self
        dataSource.configure(with: searchBar, tableView: tableView)
    }
    
    // MARK: - Private methods
    
    private func setProperties() {
        title = "MVVM-Delegate"
        view.backgroundColor = .white
    }
    
}

// MARK: - Layout

extension SearchViewController {
    
    private func layout() {
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

// MARK: - SearchViewModelDelegate

extension SearchViewController: SearchViewModelDelegate {
    
    func searchViewModelDidUpdate(_ viewModel: SearchViewModel) {
        tableView.reloadData()
    }
    
    func showRepositoryUrl(url: URL) {
        let controller = SFSafariViewController(url: url)
        present(controller, animated: true, completion: nil)
    }
    
}
