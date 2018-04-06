//
//  APIInputBase.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/21/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import Foundation
import Alamofire

class BaseRequest: NSObject {
    
    var url = ""
    var requestType = Alamofire.HTTPMethod.get
    var body: [String: Any]?
    
    init(url: String) {
        super.init()
        self.url = url
    }
    
    init(url: String, requestType: Alamofire.HTTPMethod) {
        super.init()
        self.url = url
        self.requestType = requestType
    }
    
    init(url: String, requestType: Alamofire.HTTPMethod, body: [String: Any]?) {
        super.init()
        self.url = url
        self.requestType = requestType
        self.body = body
    }
    
    var encoding: ParameterEncoding {
        switch requestType {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
