//
//  SearchViewModel.swift
//  Structure_IOS
//
//  Created by DaoLQ on 4/9/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: ViewModelType {
    private let userRepository: UserRepository
    private let navigator: SearchNavigator

    init(userRepository: UserRepository, navigator: SearchNavigator) {
        self.userRepository = userRepository
        self.navigator = navigator
    }

    func transform(input: SearchViewModel.Input) -> SearchViewModel.Output {
        let errorTracker = ErrorTracker()

        let keywordAndLimitNumber = Driver.combineLatest(input.keyword, input.limitNumber) { (keyword, number) in
            return (keyword: keyword, number: number)
        }
        let activityIndicator = ActivityIndicator()

        let canSearch = Driver.combineLatest(keywordAndLimitNumber, activityIndicator.asDriver())
        { (keywordAndLimitNumber, activityIndicator) -> Bool in
            let limit = Int(keywordAndLimitNumber.number)
            guard let number = limit else {
            return false
            }
            return !keywordAndLimitNumber.keyword.isEmpty && number <= 100 && !activityIndicator
        }

        let errorInputNumber = input.limitNumber.map { (input) -> Int? in
            return Int(input)
            }.map { (number) -> String in
                if let number = number {
                    return number > 100 ? "Input number less than or equals 100" : ""
                }
                return ""
        }

        let search = input.searchTrigger.withLatestFrom(keywordAndLimitNumber)
            .map({ (keywordAndLimitNumber) -> SearchRequest in
                let number = Int(keywordAndLimitNumber.number)
                return SearchRequest(keyword: keywordAndLimitNumber.keyword, limit: number == nil ? 0: number!)
            })
            .flatMapLatest { [unowned self] inputRequest in
                return self.userRepository.searchUsers(input: inputRequest)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }.do(onNext: { [weak self] (users) in
                    self?.navigator.toListUser(users: users)
            }).mapToVoid()

        return SearchViewModel.Output(searchButtonEnable: canSearch, errorInputNumber: errorInputNumber,
                                      search: search, error: errorTracker.asDriver(), fetching: activityIndicator.asDriver())
    }

}

extension SearchViewModel {
    struct Input {
        let keyword: Driver<String>
        let limitNumber: Driver<String>

        let searchTrigger: Driver<Void>
    }

    struct Output {
        let searchButtonEnable: Driver<Bool>
        let errorInputNumber: Driver<String>
        let search: Driver<Void>
        let error: Driver<Error>
        let fetching: Driver<Bool>
    }
}
