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
    
    let reloadData: Observable<Void>
    let showRepository: Observable<RepositoryModel>
    var repositories: [RepositoryModel] {
        return _repositories.value
    }
    
    private let _repositories: BehaviorRelay<[RepositoryModel]>
    private let disposeBag = DisposeBag()
    
    // MARK: - Con(De)structor
    
    init(searchTextDidChange: Observable<String>,
         searchButtonClicked: Observable<String>,
         indexPathDidSelected: Observable<IndexPath>) {
        
        func searchRepositories(text: String, completion: @escaping ([RepositoryModel]) -> Void) {
            GithubService().searchRepositories(query: text) { (result) in
                switch result {
                case .value(let value):
                    completion(value.items)
                case .error(_):
                    completion([])
                }
            }
        }
        
        let _reloadData = PublishSubject<Void>()
        self.reloadData = _reloadData
        
        let _repositories = BehaviorRelay<[RepositoryModel]>(value: [])
        self._repositories = _repositories
        _repositories.asObservable().map { _ in }
            .bind(to: _reloadData)
            .disposed(by: disposeBag)
        
        let _searchTextDidChange = searchTextDidChange
            .debounce(0.3, scheduler: MainScheduler.instance)
        let _searchButtonClicked = searchButtonClicked
        Observable.of(_searchTextDidChange, _searchButtonClicked).merge()
            .distinctUntilChanged()
            .subscribe(onNext: {
                searchRepositories(text: $0) {
                    _repositories.accept($0)
                }
            })
        .disposed(by: disposeBag)
        
        showRepository = indexPathDidSelected.withLatestFrom(_repositories.asObservable()) { $1[$0.row] }
    }
    
}



