//
//  CustomRequestAdapter.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/22/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import Foundation
import Alamofire

class CustomRequestAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
//        urlRequest.setValue(MY_API_KEY, forHTTPHeaderField: "X-AccessToken")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
