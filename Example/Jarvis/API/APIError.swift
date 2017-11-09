
//
//  APIError.swift
//  Jarvis_Example
//
//  Created by Sergey Degtyar on 11/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
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
        
        self = .network(statusCode, message: error?.localizedDescription)
    }
}

