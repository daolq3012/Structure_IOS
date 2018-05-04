//
//  ListUsersTableViewCell.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/24/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit

class ListUsersTableViewCell: UITableViewCell {
    static let reuseID = "ListUsersTableViewCell"

    @IBOutlet weak var userNameLabel: UILabel!

    func updateCell(user: User?) {
        userNameLabel.text = user?.login
    }
}
