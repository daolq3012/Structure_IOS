//
//  ListUsersViewController.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/24/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit
import RxSwift

class ListUsersViewController: BaseUIViewController {
    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!

    var users: [User]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search Result"

        configureTableView()
    }

    private func configureTableView() {
        tableView.register(UINib(nibName: ListUsersTableViewCell.reuseID, bundle: nil),
                            forCellReuseIdentifier: ListUsersTableViewCell.reuseID)
        tableView.estimatedRowHeight = 64
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ListUsersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListUsersTableViewCell")
        if let cell = cell as? ListUsersTableViewCell {
            cell.updateCell(user: users?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let size = users?.count {
            return size
        }
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = users?[indexPath.row] {
            print(user)
        }
    }
}
