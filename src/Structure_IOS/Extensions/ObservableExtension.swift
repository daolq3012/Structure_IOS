//
//  ObservableExtension.swift
//  Structure_IOS
//
//  Created by DaoLQ on 5/4/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation
import RxSwift

extension ObserverType where E == Void {
    public func onNext() {
        onNext(())
    }
}
