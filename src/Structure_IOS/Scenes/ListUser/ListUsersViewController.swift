//
//  ListUsersViewController.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/24/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListUsersViewController: BaseUIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: ListUserViewModel!

    @IBOutlet weak var tableView: UITableView!

    var users: [User]?

    static func createWith(viewModel: ListUserViewModel) -> ListUsersViewController {
        let viewController = ListUsersViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search Result"

        configureTableView()
        bindViewModel()
    }

    private func configureTableView() {
        tableView.register(UINib(nibName: ListUsersTableViewCell.reuseID, bundle: nil),
                            forCellReuseIdentifier: ListUsersTableViewCell.reuseID)
        tableView.estimatedRowHeight = 64
    }

    private func bindViewModel() {
        assert(viewModel != nil)
        let input = ListUserViewModel.Input(selection: tableView.rx.itemSelected.asDriver())

        let output = viewModel.transform(input: input)
        // MARK: Single Cell
//        output.users.drive(tableView.rx.items(cellIdentifier: ListUsersTableViewCell.reuseID,
//                                              cellType: ListUsersTableViewCell.self)) { (_, viewModel, cell) in
//            cell.bind(viewModel: viewModel)
//        }.disposed(by: disposeBag)

        // MARK: Multiple Cell
        output.users.asObservable().bind(to: tableView.rx.items) { (tableView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            var cell: UITableViewCell!
            if indexPath.row == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: ListUsersTableViewCell.reuseID, for: indexPath)
                (cell as! ListUsersTableViewCell).bind(viewModel: element)
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: ListUsersTableViewCell.reuseID, for: indexPath)
                (cell as! ListUsersTableViewCell).bind(viewModel: element)
            }
            return cell
        }.disposed(by: disposeBag)

        output.selectedCell.drive().disposed(by: disposeBag)
    }
}
