//
//  SearchRequest.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/21/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class SearchRequest: BaseRequest {
    
    required init(keyword: String, limit: String) {
        let body: [String: Any]  = [
            "per_page": limit,
            "q": keyword
        ]
        super.init(url: URLs.APISearchUserUrl, requestType: .get, body: body)
    }
}
