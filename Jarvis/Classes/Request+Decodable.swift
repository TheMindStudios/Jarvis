//
//  Request+Decodable.swift
//  Jarvis
//
//  Created by Max Mashkov on 9/15/17.
//

import Foundation

#if swift(>=4.0)
    
public final class DecodableResponseParser<D: Decodable, ErrorType: Jarvis.ResponseError>: ResponseParsing {
    
    public typealias Parsable = D
    public typealias ParsingError = ErrorType
    
    public init () {}
    
    public func parse(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) -> Result<Parsable, ParsingError> {
        
        guard error == nil else {
            return .failure(ErrorType(response: response, data: data, error: error))
        }
        
        do {
            guard let jsonData = data else {
                
                return .failure(ErrorType(response: response, data: data, error: error))
            }
            
            let entity = try JSONDecoder().decode(D.self, from: jsonData)
            
            return .success(entity)
        } catch let error {
            return .failure(ErrorType(response: response, data: data, error: error))
        }
    }
}

extension Request {
    
    @discardableResult
    public func responseDecodable<D: Decodable, Error>(
        completeOn queue: DispatchQueue = .main,
        completion: @escaping (Response<D, Error>) -> Void) -> Self {
        
        return response(completeOn: queue, using: DecodableResponseParser<D, Error>(), completion: completion)
    }
}

#endif
