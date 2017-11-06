//
//  RequestHeader.swift
//  Pods
//
//  Created by Max Mashkov on 3/17/17.
//
//

import Foundation

extension HTTP {
    
    public enum RequestHeader {

        case accept
        case acceptCharset
        case acceptEncoding
        case acceptDatetime
        case acceptLanguage

        case authorization
        case cacheControl
        case connection
        case cookie

        case contentType
        case contentMD5
        case contentLength

        case date
        case expect
        case forwarded
        case from
        case host

        case ifMatch
        case ifModifiedSince
        case ifNoneMatch
        case ifRange
        case ifUnmodifiedSince

        case origin

        case range
        case referer
        case userAgent
        case upgrade
        
        case custom(String)
        
        public var key: String {
            switch self {
            case .accept:
                return "Accept"
            case .acceptCharset:
                return "Accept-Charset"
            case .acceptEncoding:
                return "Accept-Encoding"
            case .acceptDatetime:
                return "Accept-Datetime"
            case .acceptLanguage:
                return "Accept-Language"
                
            case .authorization:
                return "Authorization"
            case .cacheControl:
                return "Cache-Control"
            case .connection:
                return "Connection"
            case .cookie:
                return "Cookie"
                
            case .contentType:
                return "Content-Type"
            case .contentMD5:
                return "Content-MD5"
            case .contentLength:
                return "Content-Length"
                
            case .date:
                return "Date"
            case .expect:
                return "Expect"
            case .forwarded:
                return "Forwarded"
            case .from:
                return "From"
            case .host:
                return "Host"
                
            case .ifMatch:
                return "If-Match"
            case .ifModifiedSince:
                return "If-Modified-Since"
            case .ifNoneMatch:
                return "If-None-Match"
            case .ifRange:
                return "If-Range"
            case .ifUnmodifiedSince:
                return "If-Unmodified-Since"
                
            case .origin:
                return "Origin"
            case .range:
                return "Range"
            case .referer:
                return "Referer"
            case .userAgent:
                return "User-Agent"
            case .upgrade:
                return "Upgrade"
                
            case .custom(let key):
                return key
            }
        }
    }
}
