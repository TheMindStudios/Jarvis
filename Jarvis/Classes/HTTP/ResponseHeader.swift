//
//  ResponseHeader.swift
//  Pods
//
//  Created by Max Mashkov on 3/17/17.
//
//

import Foundation

extension HTTP {

    public enum ResponseHeader: String {
        
        case acceptRanges       = "Accept-Ranges"
        case age                = "Age"
        case allow              = "Allow"
        case cacheControl       = "Cache-Control"
        case connection         = "Connection"
        
        case contentDisposition = "Content-Disposition"
        case contentEncoding    = "Content-Encoding"
        case contentLanguage    = "Content-Language"
        case contentLength      = "Content-Length"
        case contentLocation    = "Content-Location"
        case contentMD5         = "Content-MD5"
        case contentRange       = "Content-Range"
        case contentType        = "Content-Type"
        
        case date               = "Date"
        case eTag               = "ETag"
        case expires            = "Expires"
        case lastModified       = "Last-Modified"
        case link               = "Link"
        case location           = "Location"
        case refresh            = "Refresh"
        case retryAfter         = "Retry-After"
        case server             = "Server"
        case setCookie          = "Set-Cookie"
        case status             = "Status"
        case rransferEncoding   = "Transfer-Encoding"
        case upgrade            = "Upgrade"
    }
}
