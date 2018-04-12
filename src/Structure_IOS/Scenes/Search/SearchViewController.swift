//
//  ViewController.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/21/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class SearchViewController: BaseUIViewController, AlertViewController {
    private let disposeBag = DisposeBag()
    var viewModel: SearchViewModel!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var limitNumberTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    private let userRepository: UserRepository = UserRepositoryImpl(api: APIService.share)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userRepository = UserRepositoryImpl(api: APIService.share)
        let navigator = DefaultSearchNavigator(navigationController: self.navigationController)
        viewModel =  SearchViewModel(userRepository: userRepository, navigator: navigator)

        let input = SearchViewModel.Input(keyword: searchTextField.rx.text.orEmpty.asDriver(),
                                          limitNumber: limitNumberTextField.rx.text.orEmpty.asDriver(),
                                          searchTrigger: searchButton.rx.tap.asDriver())

        let output = viewModel.transform(input: input)
        output.searchButtonEnable.drive(searchButton.rx.isEnabled)
            .disposed(by: disposeBag)
        output.errorInputNumber.drive(errorInputNumberBinding).disposed(by: disposeBag)
        output.error.drive(errorBinding).disposed(by: disposeBag)
        output.search.drive().disposed(by: disposeBag)
        output.fetching.drive(SVProgressHUD.rx.isAnimating).disposed(by: disposeBag)
    }

    var errorInputNumberBinding: Binder<String> {
        return Binder(self, binding: { (viewController, errorText) in
            viewController.errorLabel.text = errorText
        })
    }

    var errorBinding: Binder<Error> {
        return Binder(self, binding: { (viewController, error) in
            guard let error = error as? BaseError else {
                return
            }
            viewController.showErrorAlert(message: error.errorMessage)
        })
    }
}
