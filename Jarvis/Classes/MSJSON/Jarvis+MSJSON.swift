//
//  Jarvis+MSJSON.swift
//  Jarvis
//
//  Created by Max Mashkov on 9/13/17.
//

import Foundation
import MSJSON

public final class JSONResponseParser<J: JSONInitializable, ErrorType: Jarvis.ResponseError>: ResponseParsing {
    
    public typealias Parsable = J
    public typealias ParsingError = ErrorType
    
    public init () {}
    
    public func parse(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) -> Result<Parsable, ParsingError> {
        
        guard error == nil else {
            return .failure(ErrorType(response: response, data: data, error: error))
        }
        
        do {
            guard let json = try data?.json(withOptions: .allowFragments), let entity = J(json: json) else {
                
                return .failure(ErrorType(response: response, data: data, error: error))
            }
            
            return .success(entity)
        } catch let error {
            return .failure(ErrorType(response: response, data: data, error: error))
        }
    }
}

extension Jarvis.Request {
    
    @discardableResult
    public func responseJSON<J: JSONInitializable, Error>(
        completeOn queue: DispatchQueue = .main,
        completion: @escaping (Response<J, Error>) -> Void) -> Self {
        
        return response(completeOn: queue, using: JSONResponseParser<J, Error>(), completion: completion)
    }
}
