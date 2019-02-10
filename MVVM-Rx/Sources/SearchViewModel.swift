//
//  SearchViewModel.swift
//  MVVM-Rx
//
//  Created by DongHeeKang on 08/12/2018.
//  Copyright © 2018 k-lpmg. All rights reserved.
//

import RxCocoa
import RxSwift

final class SearchViewModel {
    
    // MARK: - Properties
    
    let showRepository: Observable<RepositoryModel>
    let repositories: Observable<[RepositoryModel]>
    
    // MARK: - Con(De)structor
    
    init(searchTextDidChange: Observable<String>,
         searchButtonClicked: Observable<String>,
         indexPathDidSelected: Observable<IndexPath>) {
        
        func searchRepositories(text: String) -> Observable<[RepositoryModel]> {
            let repositoryModel = PublishSubject<[RepositoryModel]>()
            
            GitHubService().searchRepositories(query: text) { (result) in
                switch result {
                case .value(let value):
                    repositoryModel.onNext(value.items)
                case .error(_):
                    repositoryModel.onNext([])
                }
            }
            
            return repositoryModel.asObservable()
        }
        
        let _searchTextDidChange = searchTextDidChange.debounce(0.3, scheduler: MainScheduler.instance)
        let _searchButtonClicked = searchButtonClicked
        repositories = Observable.of(_searchTextDidChange, _searchButtonClicked).merge()
            .distinctUntilChanged()
            .flatMapLatest {
                searchRepositories(text: $0)
            }
        
        showRepository = indexPathDidSelected.withLatestFrom(repositories) { $1[$0.row] }
    }
    
}



