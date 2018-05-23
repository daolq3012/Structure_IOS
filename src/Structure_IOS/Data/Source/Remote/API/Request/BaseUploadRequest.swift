//
//  BaseUploadRequest.swift
//  Structure_IOS
//
//  Created by DaoLQ on 4/13/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseUploadRequest: NSObject {

    var url = ""
    var parameters: [String: Any]?
    var files: [File]?

    init(url: String) {
        self.url = url
    }

    init(url: String, files: [File]) {
        self.url = url
        self.files = files
    }
}

struct File {
    var key: String
    var path: String
}
