//
//  Phoenix.swift
//  Pods
//
//  Created by Max Mashkov on 9/19/16.
//
//

import Foundation

@discardableResult
public func request(_ request: Request) -> Request {

    return Client.default.request(request)
}

@discardableResult
public func request(_ requestDataProvider: RequestDataProvider) -> Request {

    return Client.default.request(requestDataProvider)
}

public var isLoggingEnabled: Bool = false
