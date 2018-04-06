//
//  BaseResult.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/23/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import Foundation
import ObjectMapper

enum BaseResult<T: Mappable> {
    case success(T?)
    case failure(error: BaseError?)
}
