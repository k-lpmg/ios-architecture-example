//
//  SearchViewDataSource.swift
//  MVVM-Rx
//
//  Created by DongHeeKang on 08/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import UIKit

import RxSwift

final class SearchViewDataSource: NSObject {
    
    // MARK: - Constants
    
    enum Const {
        static let cellReuseId = "cellId"
    }
    
    // MARK: - Properties
    
    private unowned let viewModel: SearchViewModel
    private let searchTextDidChange: AnyObserver<String>
    private let searchButtonClicked: AnyObserver<String>
    private let indexPathDidSelected: AnyObserver<IndexPath>
    
    // MARK: - Con(De)structor
    
    init(viewModel: SearchViewModel,
         searchTextDidChange: AnyObserver<String>,
         searchButtonClicked: AnyObserver<String>,
         indexPathDidSelected: AnyObserver<IndexPath>) {
        self.viewModel = viewModel
        self.searchTextDidChange = searchTextDidChange
        self.searchButtonClicked = searchButtonClicked
        self.indexPathDidSelected = indexPathDidSelected
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
        searchTextDidChange.onNext(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        searchButtonClicked.onNext(text)
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellReuseId, for: indexPath) as! RepositoryTableViewCell
        cell.configure(with: viewModel.repositories[indexPath.row])
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
        
        indexPathDidSelected.onNext(indexPath)
    }
    
}
