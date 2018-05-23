//
//  API.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/21/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import RxSwift

struct APIService {
    
    static let share = APIService()
    
    private var alamofireManager = Alamofire.SessionManager.default
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager.adapter = CustomRequestAdapter()
    }
    
    func request<T: Mappable>(input: BaseRequest) ->  Observable<T> {

        print("\n------------REQUEST INPUT")
        print("link: %@", input.url)
        print("body: %@", input.body ?? "No Body")
        print("------------ END REQUEST INPUT\n")

        return Observable.create { observer in
            self.alamofireManager.request(input.url, method: input.requestType,
                                          parameters: input.body, encoding: input.encoding)
                .validate(statusCode: 200..<500)
                .responseJSON { response in
                    print(response.request?.url ?? "Error")
                    print(response)
                    switch response.result {
                    case .success(let value):
                        if let statusCode = response.response?.statusCode {
                            if statusCode == 200 {
                                if let object = Mapper<T>().map(JSONObject: value) {
                                    observer.onNext(object)
                                }
                            } else {
                                if let object = Mapper<ErrorResponse>().map(JSONObject: value) {
                                    observer.onError(BaseError.apiFailure(error: object))
                                } else {
                                    observer.onError(BaseError.httpError(httpCode: statusCode))
                                }
                            }
                        } else {
                            observer.on(.error(BaseError.unexpectedError))
                        }
                        observer.onCompleted()
                    case .failure:
                        observer.onError(BaseError.networkError)
                        observer.onCompleted()
                    }
            }
            return Disposables.create()
        }
    }

    func upload(input: BaseUploadRequest) -> Observable<Void> {

        print("\n------------ UPLOAD INPUT")
        print("link: %@", input.url)
        print("body: %@", input.parameters ?? "No Body")
        print("------------ END UPLOAD INPUT\n")

        return Observable.create({ observer in
            self.alamofireManager.upload(multipartFormData: { multipartFormData in
                if let parameters = input.parameters {
                    for (key, value) in parameters {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                if let files = input.files {
                    files.forEach { file in
                        if let url = URL(string: file.path) {
                            multipartFormData.append(url, withName: file.key)
                        }
                    }
                }
            }, usingThreshold: UInt64.init(), to: input.url) { result in
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let error = response.error {
                            observer.onError(error)
                            return
                        }
                        observer.onNext()
                        observer.onCompleted()
                    }
                case .failure(let error):
                    observer.onError(error)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        })
    }
}
