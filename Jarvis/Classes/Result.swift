//
//  Result.swift
//  Pods
//
//  Created by Max Mashkov on 9/14/16.
//
//

import Foundation

public enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}
