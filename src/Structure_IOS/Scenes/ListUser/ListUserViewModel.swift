//
//  ListUserViewModel.swift
//  Structure_IOS
//
//  Created by DaoLQ on 4/12/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListUserViewModel: ViewModelType {

    var users: [User]

    init(users: [User]) {
        self.users = users
    }

    func transform(input: ListUserViewModel.Input) -> ListUserViewModel.Output {

        let userItemViewModels = Observable.just(self.users).asDriverOnErrorJustComplete()
            .map { $0.map { UserItemViewModel(with: $0) }}
        let selectedCell = input.selection.withLatestFrom(userItemViewModels)
        { (indexPath, userItemViewModels) -> User in
            return userItemViewModels[indexPath.row].user
        }
        return Output(users: userItemViewModels, selectedCell: selectedCell)
    }
}

extension ListUserViewModel {
    struct Input {
        let selection: Driver<IndexPath>
    }

    struct Output {
        let users: Driver<[UserItemViewModel]>
        let selectedCell: Driver<User>
    }
}
