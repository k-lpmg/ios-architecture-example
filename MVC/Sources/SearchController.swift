//
//  SearchController.swift
//  MVC
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import SafariServices
import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Const {
        static let cellReuseId = "cellId"
    }
    
    // MARK: - Properties
    
    private var searchText: String = ""
    private var repositories: [RepositoryModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var numberOfRepositories: Int {
        return repositories.count
    }
    
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
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: Const.cellReuseId)
        return tableView
    }()
    private var searchTimer: Timer?
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        layout()
    }
    
    // MARK: - Private methods
    
    private func setProperties() {
        title = "MVC"
        view.backgroundColor = .white
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func startSearchTimer() {
        searchTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(searchTimerCompleted), userInfo: nil, repeats: false)
    }
    
    private func removeSearchTimer() {
        searchTimer?.invalidate()
        searchTimer = nil
    }
    
    private func requestRepositories(searchText: String) {
        GithubService().searchRepositories(query: searchText) { (result) in
            switch result {
            case .value(let value):
                self.repositories = value.items
            case .error(_):
                self.repositories = []
            }
        }
    }
    
    // MARK: - Private selector
    
    @objc private func searchTimerCompleted() {
        requestRepositories(searchText: searchText)
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
        removeSearchTimer()
        startSearchTimer()
        self.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        removeSearchTimer()
        self.searchText = text
        searchTimerCompleted()
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRepositories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellReuseId, for: indexPath) as! RepositoryTableViewCell
        cell.configure(with: repositories[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let url = URL(string: repositories[indexPath.row].html_url) else {return}
        let controller = SFSafariViewController(url: url)
        present(controller, animated: true, completion: nil)
    }
    
}

