//
//  SearchNavigator.swift
//  Structure_IOS
//
//  Created by DaoLQ on 4/9/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation
import UIKit

protocol SearchNavigator {

    func toListUser(users: [User])
}

final class DefaultSearchNavigator: SearchNavigator {
    private let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func toListUser(users: [User]) {
        let listUserViewController = ListUsersViewController.createWith(viewModel: ListUserViewModel(users: users))
        navigationController?.pushViewController(listUserViewController, animated: false)
    }
}
