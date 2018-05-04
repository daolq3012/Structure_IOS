//
//  SearchPresenter.swift
//  Structure_IOS
//
//  Created by DaoLQ on 5/4/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation
import RxSwift

class SearchPresenterImpl: SearchPresenter {

    private let view: SearchView
    private let userRepository: UserRepository;

    private let disposeBag = DisposeBag()

    init(view: SearchView, userRepository: UserRepository) {
        self.view = view
        self.userRepository = userRepository
    }

    func search(keyword: String, limit: String) {
        let searchRequest = SearchRequest(keyword: keyword, limit: limit)
        self.userRepository.searchUsers(input: searchRequest)
            .subscribe(onNext: { [weak self] users in
            self?.view.onSearchSuccess(users: users)
        }, onError: { [weak self] error in
            self?.view.onSearchError(error: error as! BaseError)
        }).disposed(by: disposeBag)
    }
}
