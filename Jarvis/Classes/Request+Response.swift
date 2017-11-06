//
//  Request+Response.swift
//  Alamofire
//
//  Created by Max Mashkov on 9/14/17.
//

import Foundation
import Alamofire

extension Request {
    
    @discardableResult
    public func response<Parser: ResponseParsing>(
        completeOn queue: DispatchQueue = .main,
        using parser: Parser,
        completion: @escaping (Response<Parser.Parsable, Parser.ParsingError>) -> Void) -> Self {
        
        parsingQueue.addOperation {
            
            let internalResponse = self.internalResponse
            
            let result = parser.parse(
                request: internalResponse?.request,
                response: internalResponse?.response,
                data: internalResponse?.data,
                error: internalResponse?.result.error
            )
            
            let response = Response(
                request: internalResponse?.request,
                response: internalResponse?.response,
                data: internalResponse?.data,
                result: result
            )
            
            queue.async {
                completion(response)
            }
        }
        
        return self
    }
    
    @discardableResult
    public func response<Error>(
        completeOn queue: DispatchQueue = .main,
        completion: @escaping (Response<Data?, Error>) -> Void) -> Self {
        
        let parser = ResponseParser<Data?, Error> { _, response, data, error in
            
            guard error == nil else {
                return .failure(Error(response: response, data: data, error: error))
            }
            
            return .success(data)
        }
        
        return response(completeOn: queue, using: parser, completion: completion)
    }
}
