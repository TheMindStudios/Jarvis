//
//  Request.swift
//  Pods
//
//  Created by Max Mashkov on 10/30/15.
//  Copyright © 2016 MindStudios. All rights reserved.
//

import Foundation
import Alamofire

public typealias Parameters = [String: Any]

open class Request {

    public typealias ProgressHandler = (Progress) -> Void

    public let url: URLConvertible
    public let method: HTTP.Method
    public let parameters: Parameters?
    public let multipartData: [MultipartData]?
    public let headers: HTTP.Headers?
    public let encoding: Alamofire.ParameterEncoding
    public let formDataBuilder: FormDataBuilder
    public let acceptableStatusCodes: [Int]

    let requestQueue: OperationQueue = {
        let operationQueue = OperationQueue()

        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.isSuspended = true
        operationQueue.qualityOfService = .utility

        return operationQueue
    }()

    let parsingQueue: OperationQueue = {
        let operationQueue = OperationQueue()

        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.isSuspended = true
        operationQueue.qualityOfService = .utility

        return operationQueue
    }()

    var internalRequest: Alamofire.DataRequest? {
        didSet {
            internalRequest?.validate(statusCode: acceptableStatusCodes)
            requestQueue.isSuspended = false
        }
    }

    var internalResponse: Alamofire.DataResponse<Data>? {
        didSet {
            parsingQueue.isSuspended = false
        }
    }

    init(
        url: URLConvertible,
        method: HTTP.Method,
        parameters: Parameters? = nil,
        multipartData: [MultipartData]? = nil,
        formDataBuilder: FormDataBuilder = DefaultFormDataBuilder(),
        headers: HTTP.Headers? = nil,
        encoding: Alamofire.ParameterEncoding = URLEncoding.default,
        acceptableStatusCodes: [Int] = Array(200..<300)) {

        self.url = url
        self.method = method
        self.parameters = parameters
        self.multipartData = multipartData
        self.formDataBuilder = formDataBuilder
        self.headers = headers
        self.encoding = encoding
        self.acceptableStatusCodes = acceptableStatusCodes
    }

    open func resume() {

        requestQueue.addOperation { [weak self] in
            self?.internalRequest?.resume()
        }
    }

    open func suspend() {

        requestQueue.addOperation { [weak self] in
            self?.internalRequest?.suspend()
        }
    }

    open func cancel() {

        requestQueue.addOperation { [weak self] in
            self?.internalRequest?.cancel()
        }
    }
}
