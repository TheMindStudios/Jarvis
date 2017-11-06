//
//  Client.swift
//  Pods
//
//  Created by Max Mashkov on 9/2/15.
//  Copyright © 2016 MindStudios. All rights reserved.
//

import Foundation
import Alamofire

#if os(iOS)
    import AlamofireNetworkActivityIndicator
#endif

open class Client {

    open static var `default` = Client()

    fileprivate let responseQueue = DispatchQueue(label: "client.response", attributes: [])

    public let manager: Alamofire.SessionManager
    public static var adapter: ((URLRequest) -> URLRequest)?
    public static var responseHandler: ((HTTPURLResponse?) -> Void)?
    public var startRequestsImmediately: Bool = true {
        didSet {
            manager.startRequestsImmediately = startRequestsImmediately
        }
    }

    #if os(iOS)
    public var networkActivityIndicatorIsEnabled: Bool {
        get {
            return NetworkActivityIndicatorManager.shared.isEnabled
        }
        
        set {
            NetworkActivityIndicatorManager.shared.isEnabled = newValue
        }
    }
    #endif

    public init(manager: Alamofire.SessionManager = Alamofire.SessionManager.default) {
        
        self.manager = manager
        self.manager.startRequestsImmediately = startRequestsImmediately
        self.manager.adapter = self
        
        #if os(iOS)
            self.networkActivityIndicatorIsEnabled = true
        
            NetworkActivityIndicatorManager.shared.startDelay = 0.0
        #endif
    }

    @discardableResult
    public func request(_ request: Request) -> Request {
        
        if isLoggingEnabled {
            request.log()
        }

        alamofireRequest(for: request) { result in

            switch result {
            case .success(let alamofireRequest):
                request.internalRequest = alamofireRequest
                
                alamofireRequest.responseData { response in
                    request.internalResponse = response
                    Client.responseHandler?(response.response)
                }
            case .failure(let error):
                
                let result = Alamofire.Result<Data>.failure(error)
                
                request.internalResponse = Alamofire.DataResponse<Data>(
                    request: nil,
                    response: nil,
                    data: nil,
                    result: result
                )
            }
            
            if isLoggingEnabled {
                request.logResponse()
            }
        }

        return request
    }

    @discardableResult
    public func request(_ requestDataProvider: RequestDataProvider) -> Request {

        return self.request(requestDataProvider.request)
    }
}

extension Client {
    
    private enum CreatingAlamofireRequestResult {
        case success(Alamofire.DataRequest)
        case failure(Swift.Error)
    }

    private func alamofireRequest(for request: Request, completion: @escaping (CreatingAlamofireRequestResult) -> Void) {

        let method = request.method.asAlamofireHTTPMethod()
        
        if request.multipartData != nil {

            manager.upload(multipartFormData: { formData in

                request.formDataBuilder.fillFormData(formData, for: request)

            }, to: request.url.asURL(), method: method, headers: request.headers, encodingCompletion: { result in

                    switch result {
                    case .success(let upload, _, _):

                        completion(.success(upload))

                    case .failure(let encodingError):
                        completion(.failure(encodingError))
                    }
            })

        } else {

            let alamofireRequest = manager.request(
                request.url.asURL(),
                method: method,
                parameters: request.parameters,
                encoding: request.encoding,
                headers: request.headers
            )

            completion(.success(alamofireRequest))
        }
    }
    
    public func cancelAllRequests() {
        
        manager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
}

extension Client: RequestAdapter {

    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        return Client.adapter?(urlRequest) ?? urlRequest
    }
}
