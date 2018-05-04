//
//  BaseNavigator.swift
//  Structure_IOS
//
//  Created by DaoLQ on 5/16/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigator {
    let navigationController: UINavigationController?

    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
