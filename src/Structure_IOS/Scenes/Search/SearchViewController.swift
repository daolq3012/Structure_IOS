//
//  ViewController.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/21/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit


class SearchViewController: BaseUIViewController, AlertViewController {
    
    @IBOutlet weak var searchTextField: UITextField?
    @IBOutlet weak var limitNumberTextField: UITextField?
    @IBOutlet weak var searchButton: UIButton?
    
    private let userRepository: UserRepository = UserRepositoryImpl(api: APIService.share)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func searchButtonClicked(_ sender: Any) {
        let keyword = searchTextField?.text
        let limit = limitNumberTextField?.text
        if let keyword = keyword, let limit = limit {
            if let limit = Int(limit) {
                userRepository.searchUsers(keyword: keyword, limit: limit) { (result) in
                    switch result {
                    case .success(let searchResponse):
                        let listUserVC = ListUsersViewController()
                        listUserVC.users = searchResponse?.users
                        self.navigationController?.pushViewController(listUserVC, animated: true)
                    case .failure(let error):
                        self.showErrorAlert(message: error?.errorMessage)
                    }
                }
            }
        }
    }
    
}
