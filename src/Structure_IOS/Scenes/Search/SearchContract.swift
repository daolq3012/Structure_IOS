//
//  SearchContract.swift
//  Structure_IOS
//
//  Created by DaoLQ on 5/4/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation

protocol SearchView: class {
    func onSearchError(error: BaseError)

    func onSearchSuccess(users: [User])
}

protocol SearchPresenter: class {
    func search(keyword: String, limit: String)
}
