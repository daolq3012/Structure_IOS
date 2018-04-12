//
//  UserItemViewModel.swift
//  Structure_IOS
//
//  Created by DaoLQ on 4/12/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation

final class UserItemViewModel {
    let login: String?
    let user: User

    init(with user: User) {
        self.user = user
        self.login = user.login
    }
}
