//
//  ObservableExtension.swift
//  Structure_IOS
//
//  Created by DaoLQ on 4/11/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SVProgressHUD

extension ObservableType where E == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }

}

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

extension ObservableType {

    func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }

    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

extension ObserverType where E == Void {
    public func onNext() {
        onNext(())
    }
}

extension Reactive where Base: SVProgressHUD {

    /// Bindable sink for `show()`, `hide()` methods.
    public static var isAnimating: Binder<Bool> {
        return Binder(UIApplication.shared) { _, isVisible in
            if isVisible {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
}
