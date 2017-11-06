//
//  URLConvertible.swift
//  Pods
//
//  Created by Max Mashkov on 9/28/16.
//
//

import Foundation

public protocol URLConvertible {

    func asURL() -> URL
}

extension String: URLConvertible {

    public func asURL() -> URL {
        return URL(string: self)!
    }
}

extension URL: URLConvertible {

    public func asURL() -> URL {
        return self
    }
}

extension URLComponents: URLConvertible {

    public func asURL() -> URL {
        return url!
    }
}
