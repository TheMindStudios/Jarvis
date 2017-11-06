//
//  Request+Logging.swift
//  Alamofire
//
//  Created by Max Mashkov on 9/14/17.
//

import Foundation

extension Request {
    
    @discardableResult
    public func log() -> Self {
        
        print("\nJarvis:")
        
        print("\(method.rawValue) \(url.asURL().absoluteString)")
        
        if let headers = headers {
            print("Headers: \(headers)")
        }
        
        if let parameters = parameters {
            print("Parameters: \(parameters)")
        }
        
        if let multipartData = multipartData {
            print("Multipart Data: \(multipartData)")
        }
        
        print("\n")
        
        return self
    }
    
    @discardableResult
    public func logResponse() -> Self {
        
        parsingQueue.addOperation {
            
            if let internalResponse = self.internalResponse {
                
                switch internalResponse.result {
                case .success:
                    
                    if let response = internalResponse.response {
                        print("\nJarvis:")
                        print("\(response.statusCode) \(self.method) \(String(describing: response.url?.absoluteString))")
                        print("\(response)")
                        print("\n")
                    }
                    
                case .failure(let error):
                    
                    print("\nJarvis:")
                    print("\(self.method) \(self.url.asURL().absoluteString)")
                    print("Error: \(error.localizedDescription)")
                    print("\n")
                }
            }
        }
        
        return self
    }
}
