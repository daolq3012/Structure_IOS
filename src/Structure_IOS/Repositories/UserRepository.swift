//
//  SearchRepository.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/23/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

protocol UserRepository {
    func searchUsers(input: SearchRequest) -> Observable<[User]>
}

class UserRepositoryImpl: UserRepository {
    
    private var api: APIService!
    
    required init(api: APIService) {
        self.api = api
    }

    func searchUsers(input: SearchRequest) -> Observable<[User]> {
        return api.request(input: input)
            .map({ (response: SearchResponse) -> [User] in
            return response.users
        })
    }
}
