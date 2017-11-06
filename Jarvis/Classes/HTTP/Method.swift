//
//  Method.swift
//  Jarvis
//
//  Created by Max Mashkov on 9/19/17.
//

import Foundation
import Alamofire

extension HTTP {
    
    public enum Method: String {
        
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
        
        public func asAlamofireHTTPMethod() -> Alamofire.HTTPMethod {
            
            return Alamofire.HTTPMethod(rawValue: rawValue)!
        }
    }
}
