//
//  SearchView.swift
//  MVP
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import SafariServices
import UIKit

protocol SearchView: class {
    func reloadData()
    func showRepositoryUrl(url: URL)
}

final class SearchViewController: UIViewController, SearchView {
    
    // MARK: - Properties
    
    private let presenter: SearchPresenter
    private let dataSource: SearchViewDataSource
    
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
    
    // MARK: - Con(De)structor
    
    init() {
        presenter = SearchViewPresenter()
        dataSource = SearchViewDataSource(presenter: presenter)
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        layout()
    }
    
    // MARK: - Internal methods
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showRepositoryUrl(url: URL) {
        let controller = SFSafariViewController(url: url)
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func setProperties() {
        title = "MVP"
        view.backgroundColor = .white
        searchBar.delegate = self
        dataSource.configure(with: tableView)
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

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchRepositories()
    }
    
}
