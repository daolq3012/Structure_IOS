//
//  SearchRepository.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/23/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import Foundation
import ObjectMapper

protocol UserRepository {
    func searchUsers(keyword: String, limit: Int, completion: @escaping (BaseResult<SearchResponse>) -> Void)
}

class UserRepositoryImpl: UserRepository {
    
    private var api: APIService?
    
    required init(api: APIService) {
        self.api = api
    }
    
    func searchUsers(keyword: String, limit: Int, completion: @escaping (BaseResult<SearchResponse>) -> Void) {
        let input = SearchRequest(keyword: keyword, limit: limit)
        
        api?.request(input: input) { (object: SearchResponse?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
}
