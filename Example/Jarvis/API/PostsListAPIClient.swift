//
//  PostsListAPIClient.swift
//  Jarvis_Example
//
//  Created by Sergey Degtyar on 11/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Jarvis

struct PostsListAPIClient {
    
    enum Route: RequestDataProvider {
        
        case get(page: Int)
        
        var method: HTTP.Method {
            return .get
        }
        
        var baseUrl: URLConvertible {
            
            return URL(string: "http://jsonplaceholder.typicode.com")!
        }
        
        var path: String {
            
            switch self {
            case .get:
                return "posts"
            }
        }
        
        var parameters: Parameters? {
            
            switch self {
            case .get(let page):
                return ["page": page]
            }
        }
    }
}

// MARK: - PostsListAPI

extension PostsListAPIClient: PostsListAPI {
    
    func getPosts(for page: Int, completion: @escaping (_ response: Response<[Post], APIError>) -> Void) {
        
        let request = Route.get(page: page)
        Jarvis.request(request).responseDecodable(completion: completion)
    }
}

