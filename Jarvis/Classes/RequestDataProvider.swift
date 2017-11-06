//
//  RequestDataProvider.swift
//  Pods
//
//  Created by Max Mashkov on 6/10/16.
//  Copyright © 2016 MindStudios. All rights reserved.
//

import Foundation
import Alamofire

public protocol RequestDataProvider {

    var baseUrl: URLConvertible { get }
    var path: String { get }
    var method: HTTP.Method { get }
    var parameters: Parameters? { get }
    var multipartData: [MultipartData]? { get }
    var headers: HTTP.Headers? { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var formDataBuilder: FormDataBuilder { get }
    var acceptableStatusCodes: [Int] { get }
}

public extension RequestDataProvider {
    
    var method: HTTP.Method {
        return .get
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: HTTP.Headers? {
        return nil
    }
    
    var multipartData: [MultipartData]? {
        return nil
    }

    var formDataBuilder: FormDataBuilder {
        return DefaultFormDataBuilder()
    }
    
    var url: URL {
        return baseUrl.asURL().appendingPathComponent(path)
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
    var acceptableStatusCodes: [Int] {
        return Array(200..<300)
    }
    
    var request: Request {
        
        return Request(
            url: url,
            method: method,
            parameters: parameters,
            multipartData: multipartData,
            formDataBuilder: formDataBuilder,
            headers: headers,
            encoding: encoding,
            acceptableStatusCodes: acceptableStatusCodes
        )
    }
}
