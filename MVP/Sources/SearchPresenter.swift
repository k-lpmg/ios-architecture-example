//
//  SearchPresenter.swift
//  MVP
//
//  Created by DongHeeKang on 07/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import Foundation

protocol SearchPresenter: class {
    var view: SearchView? { get set }
    var numberOfRepositories: Int { get }
    var searchText: String? { get set }
    func repository(at index: Int) -> RepositoryModel
    func showRepositoryUrl(at index: Int)
    func searchRepositories()
}

final class SearchViewPresenter: SearchPresenter {
    
    // MARK: - Properties
    
    weak var view: SearchView?
    var numberOfRepositories: Int {
        return repositories.count
    }
    var searchText: String? {
        didSet {
            removeSearchTimer()
            startSearchTimer()
        }
    }
    
    private var repositories: [RepositoryModel] = [] {
        didSet {
            self.view?.reloadData()
        }
    }
    private var searchTimer: Timer?
    
    // MARK: - Public methods
    
    public func repository(at index: Int) -> RepositoryModel {
        return repositories[index]
    }
    
    public func showRepositoryUrl(at index: Int) {
        guard let url = URL(string: repository(at: index).html_url) else {return}
        view?.showRepositoryUrl(url: url)
    }
    
    public func searchRepositories() {
        removeSearchTimer()
        searchTimerCompleted()
    }
    
    // MARK: - Private methods
    
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
        guard let searchText = searchText else {return}
        requestRepositories(searchText: searchText)
    }
    
}
