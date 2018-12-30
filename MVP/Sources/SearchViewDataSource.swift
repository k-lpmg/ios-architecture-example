//
//  SearchViewDataSource.swift
//  MVP
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import UIKit

final class SearchViewDataSource: NSObject {
    
    // MARK: - Constants
    
    enum Const {
        static let cellReuseId = "cellId"
    }
    
    // MARK: - Properties
    
    private let presenter: SearchPresenter
    
    // MARK: - Con(De)structor
    
    init(presenter: SearchPresenter) {
        self.presenter = presenter
    }
    
    // MARK: - Internal methods
    
    func configure(with searchBar: UISearchBar, tableView: UITableView) {
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: Const.cellReuseId)
    }
    
}

// MARK: - UISearchBarDelegate

extension SearchViewDataSource: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchRepositories()
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRepositories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellReuseId, for: indexPath) as! RepositoryTableViewCell
        cell.configure(with: presenter.repository(at: indexPath.row))
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension SearchViewDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        presenter.showRepositoryUrl(at: indexPath.row)
    }
    
}
