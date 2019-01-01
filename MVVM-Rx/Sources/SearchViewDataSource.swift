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
    private let indexPathDidSelected: AnyObserver<IndexPath>
    
    // MARK: - Con(De)structor
    
    init(viewModel: SearchViewModel,
         indexPathDidSelected: AnyObserver<IndexPath>) {
        self.viewModel = viewModel
        self.indexPathDidSelected = indexPathDidSelected
    }
    
    // MARK: - Internal methods
    
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: Const.cellReuseId)
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
