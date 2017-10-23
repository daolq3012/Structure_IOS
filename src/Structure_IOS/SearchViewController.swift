//
//  ViewController.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/21/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit


class SearchViewController: BaseUIViewController {
    
    @IBOutlet weak var searchTextField: UITextField?
    @IBOutlet weak var limitNumberTextField: UITextField?
    @IBOutlet weak var searchButton: UIButton?
    
    private let userRepository: UserRepository = UserRepositoryImpl(api: APIService.share)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userRepository.searchUsers(keyword: "abc", limit: 12) { (result) in
            switch result {
            case .success( _):
//                print(searchResponse?.users)
                break
            case .failure( _):
//                print(error)
                break
            }
        }
    }
}
