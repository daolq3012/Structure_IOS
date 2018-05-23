//
//  ViewModelType.swift
//  Structure_IOS
//
//  Created by DaoLQ on 4/10/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
