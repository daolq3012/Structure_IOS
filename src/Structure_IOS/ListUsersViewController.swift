//
//  ListUsersViewController.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/24/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit

class ListUsersViewController: BaseUIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    var users: [User]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search Result"
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: "ListUsersTableViewCell", bundle: nil), forCellReuseIdentifier: "ListUsersTableViewCell")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = users?[indexPath.row] {
            // TODO: handle later
            print(user)
        }
    }
}
