//
//  Response.swift
//  Pods
//
//  Created by Max Mashkov on 10/30/15.
//  Copyright © 2015 MindStudios. All rights reserved.
//

import Foundation

public struct Response<Value, Error: ResponseError> {

    public let request: URLRequest?
    public let response: HTTPURLResponse?
    public let statusCode: HTTP.StatusCode?
    public let data: Data?
    public let result: Result<Value, Error>

    public init(request: URLRequest?, response: HTTPURLResponse?, data: Data?, result: Result<Value, Error>) {
        
        self.request = request
        self.response = response
        
        if let response = response {
            self.statusCode = HTTP.StatusCode(rawValue: response.statusCode)
        } else {
            self.statusCode = nil
        }
        
        self.data = data
        self.result = result
    }
    
    public func headerValue(for key: String) -> Any? {
        return response?.allHeaderFields[key]
    }
    
    public func headerValue(for key: HTTP.ResponseHeader) -> Any? {
        return headerValue(for: key.rawValue)
    }
}
