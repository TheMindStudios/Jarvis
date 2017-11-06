//
//  ResponseError.swift
//  Pods
//
//  Created by Max Mashkov on 5/31/17.
//
//

import Foundation

public protocol ResponseError: Swift.Error {
    init(response: HTTPURLResponse?, data: Data?, error: Error?)
}
