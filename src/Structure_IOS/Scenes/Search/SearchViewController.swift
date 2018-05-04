//
//  ViewController.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/21/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD

class SearchViewController: BaseUIViewController, SearchView, AlertViewController {
    private let disposeBag = DisposeBag()

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var limitNumberTextField: UITextField!

    private var presenter: SearchPresenter?
    private var navigator: SearchNavigator?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigator = DefaultSearchNavigator(navigationController: self.navigationController)

        let userRepository = UserRepositoryImpl.sharedInstance
        presenter = SearchPresenterImpl(view: self, userRepository: userRepository)
    }

    @IBAction func didTapSearchButton(_ sender: Any) {
        guard let keyword = searchTextField.text, let limit = limitNumberTextField.text else {
            return
        }
        SVProgressHUD.show()
        presenter?.search(keyword: keyword, limit: limit)
    }

    func onSearchSuccess(users: [User]) {
        SVProgressHUD.dismiss()
        navigator?.toListUser(users: users)
    }

    func onSearchError(error: BaseError) {
        SVProgressHUD.dismiss()
        showErrorAlert(message: error.errorMessage)
    }
}
