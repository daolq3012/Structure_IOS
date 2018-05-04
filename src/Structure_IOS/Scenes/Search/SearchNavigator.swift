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

final class DefaultSearchNavigator: BaseNavigator,SearchNavigator {

    func toListUser(users: [User]) {
        let listUserViewController = ListUsersViewController()
        listUserViewController.users = users
        navigationController?.pushViewController(listUserViewController, animated: false)
    }
}
