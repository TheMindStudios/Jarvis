//
//  Request+Progress.swift
//  Alamofire
//
//  Created by Max Mashkov on 9/14/17.
//

import Foundation
import Alamofire

extension Request {
    
    @discardableResult
    public func uploadProgress(queue: DispatchQueue = .main, completion: @escaping ProgressHandler) -> Self {
        
        requestQueue.addOperation { [weak self] in
            if let uploadRequest = self?.internalRequest as? Alamofire.UploadRequest {
                uploadRequest.uploadProgress(queue: queue, closure: completion)
            }
        }
        
        return self
    }
    
    @discardableResult
    public func downloadProgress(queue: DispatchQueue = .main, completion: @escaping ProgressHandler) -> Self {
        
        requestQueue.addOperation { [weak self] in
            self?.internalRequest?.downloadProgress(queue: queue, closure: completion)
        }
        
        return self
    }
}
