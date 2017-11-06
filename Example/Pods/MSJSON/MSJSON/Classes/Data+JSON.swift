//
//  Data+JSON.swift
//  Pods
//
//  Created by Max Mashkov on 9/14/16.
//
//

import Foundation

public enum DataParsingError: Error {
    case cannotConvertToJSON
}

public extension Data {

    public func json(withOptions options: JSONSerialization.ReadingOptions = []) throws -> JSON {

        guard let json = try JSONSerialization.jsonObject(with: self, options: options) as? JSON else {
            throw DataParsingError.cannotConvertToJSON
        }

        return json
    }
}
