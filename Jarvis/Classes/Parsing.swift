//
//  Parsing.swift
//  Pods
//
//  Created by Max Mashkov on 6/23/16.
//  Copyright © 2016 MindStudios. All rights reserved.
//

import Foundation

public protocol ResponseParsing {
    
    associatedtype Parsable
    associatedtype ParsingError: Error
    
    func parse(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) -> Result<Parsable, ParsingError>
}

public struct ResponseParser<Value, ErrorType: Error>: ResponseParsing {

    public typealias Parsable = Value
    public typealias ParsingError = ErrorType
    
    private let parseResponseHandler: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<Parsable, ParsingError>
    
    public init(parseResponseHandler: @escaping (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<Parsable, ParsingError>) {
        self.parseResponseHandler = parseResponseHandler
    }

    public func parse(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) -> Result<Parsable, ParsingError> {
        return parseResponseHandler(request, response, data, error)
    }
}
