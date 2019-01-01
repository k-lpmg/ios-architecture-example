//
//  SearchView.swift
//  MVVM-Rx
//
//  Created by DongHeeKang on 08/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import SafariServices
import UIKit

import RxCocoa
import RxSwift

final class SearchViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Const {
        static let cellReuseId = "cellId"
    }
    
    // MARK: - Properties
    
    private var reloadData: AnyObserver<Void> {
        return Binder(self) { me, _ in
            me.tableView.reloadData()
        }.asObserver()
    }
    private var showRepository: AnyObserver<RepositoryModel> {
        return Binder(self) { me, repository in
            guard let url = URL(string: repository.html_url) else {return}
            let controller = SFSafariViewController(url: url)
            me.present(controller, animated: true, completion: nil)
        }.asObserver()
    }
    private let searchTextDidChange = PublishSubject<String>()
    private let searchButtonClicked = PublishSubject<String>()
    private let indexPathDidSelected = PublishSubject<IndexPath>()
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource: SearchViewDataSource = {
        return .init(viewModel: self.viewModel,
                     indexPathDidSelected: self.indexPathDidSelected.asObserver())
    }()
    private lazy var viewModel: SearchViewModel = {
        return .init(searchTextDidChange: searchTextDidChange,
                     searchButtonClicked: searchButtonClicked,
                     indexPathDidSelected: indexPathDidSelected)
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
        
        setBindings()
        setProperties()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        layout()
    }
    
    // MARK: - Private methods
    
    private func setBindings() {
        viewModel.reloadData
            .bind(to: reloadData)
            .disposed(by: disposeBag)
        
        viewModel.showRepository
            .bind(to: showRepository)
            .disposed(by: disposeBag)
    }
    
    private func setProperties() {
        title = "MVVM-Rx"
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
        searchTextDidChange.onNext(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        searchButtonClicked.onNext(text)
    }
    
}
