
//
//  APIError.swift
//  Jarvis_Example
//
//  Created by Sergey Degtyar on 11/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import MSJSON
import Jarvis

public enum APIError: Jarvis.ResponseError, LocalizedError {
    
    case cancelled
    case parsingFailed
    case noInternetConnection
    case network(HTTP.StatusCode, message: String?)
    
    public var errorDescription: String? {
        
        switch self {
        case .cancelled:
            return nil
        case .parsingFailed:
            return "Unexpected response"
        case .noInternetConnection:
            return "No Internet connection"
        case .network(let statusCode, let message):
            
            if let message = message {
                return message
            } else {
                switch statusCode {
                case .unauthorized:
                    return "Unauthorized"
                case .notFound:
                    return "Resource not found"
                case .internalServerError:
                    return "Internal server error"
                default:
                    return "Internal server error"
                }
            }
        }
    }
    
    public init(response: HTTPURLResponse?, data: Data?, error: Error?) {
        
        if let error = error as NSError? {
            
            switch (error.domain, error.code) {
            case (NSURLErrorDomain, NSURLErrorNotConnectedToInternet):
                self = .noInternetConnection
                return
            case (_, NSURLErrorCancelled):
                self = .cancelled
                return
            default:
                break
            }
        }
        
        guard let httpResponse = response, let statusCode = HTTP.StatusCode(rawValue: httpResponse.statusCode) else {
            self = .parsingFailed
            return
        }
        
        let message: String? = errorMessage(for: response, data: data, error: error)
        self = .network(statusCode, message: message)
    }
}

public enum DataParsingError: Error {
    case cannotConvertToJSON
}

public extension Data {
    
    public func parse(withOptions options: JSONSerialization.ReadingOptions = []) throws -> JSON {
        
        guard let json = try JSONSerialization.jsonObject(with: self, options: options) as? JSON else {
            throw DataParsingError.cannotConvertToJSON
        }
        
        return json
    }
}

private func errorMessage(for response: HTTPURLResponse?, data: Data?, error: Error?) -> String? {
    
    let json: JSON?
    
    do {
        json = try data?.parse(withOptions: .allowFragments)
    } catch {
        return nil
    }
    
    if let errorValue = json?["error"]?.string {
        return errorValue
    }
    
    if let error = error as NSError?, error.code != NSURLErrorCancelled {
        return error.localizedDescription
    } else {
        return nil
    }
}
