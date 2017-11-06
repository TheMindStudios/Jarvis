//
//  StatusCode.swift
//  Pods
//
//  Created by Max Mashkov on 3/17/17.
//
//

import Foundation

extension HTTP {

    public enum StatusCode: Int {

        case `continue` = 100
        case switchingProtocols = 101
        case processing = 102
        case checkpoint = 103

        case ok = 200
        case created = 201
        case noContent = 204
        case partialContent = 206
        case multiStatus = 207
        case alreadyReported = 208
        case imUsed = 226

        case multipleChoices = 300
        case movedPermanently = 301
        case found = 302
        case seeOther = 303
        case notModified = 304
        case useProxy = 305
        case temporaryRedirect = 307
        case permanentRedirect = 308

        case badRequest = 400
        case unauthorized = 401
        case paymentRequired = 402
        case forbidden = 403
        case notFound = 404
        case methodNotAllowed = 405
        case notAcceptable = 406
        case requestTimeout = 408
        case lengthRequired = 411
        case payloadTooLarge = 413
        case uriTooLong = 414
        case rangeNotSatisfiable = 416
        case unprocessableEntity = 422
        case tooManyRequests = 429
        case requestHeaderFieldsTooLarge = 431
        case nginxNoResponse = 444
        case retryWith = 449
        case nginxSSLCertificateError = 495
        case nginxSSLCertificateRequired = 496
        case nginxHTTPToHTTPS = 497
        case nginxClientClosedRequest = 499

        case internalServerError = 500
        case notImplemented = 501
        case badGateway = 502
        case serviceUnavailable = 503
        case gatewayTimeout = 504
        case httpVersionNotSupported = 505
        case loopDetected = 508
        case networkAuthenticationRequired = 511
    }
}

public extension HTTP.StatusCode {

    public enum Family {
        case informational
        case success
        case redirection
        case clientError
        case serverError
    }

    public var family: Family {
        switch rawValue {
        case 100...199:
            return .informational
        case 200...299:
            return .success
        case 300...399:
            return .redirection
        case 400...499:
            return .clientError
        case 500...599:
            return .serverError
        default:
            return .clientError
        }
    }
}

public extension HTTP.StatusCode {

    public var localizedFailureReason: String {
        return HTTPURLResponse.localizedString(forStatusCode: rawValue)
    }
}

extension HTTP.StatusCode: CustomDebugStringConvertible, CustomStringConvertible {

    public var description: String {
        return "\(rawValue) - " + localizedFailureReason
    }

    public var debugDescription: String {
        return "HTTPStatusCode: \(description)"
    }
}
