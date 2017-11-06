//
//  PostsListAPI.swift
//  Jarvis_Example
//
//  Created by Sergey Degtyar on 11/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Jarvis

protocol PostsListAPI {
    
    func getPosts(for page: Int, completion: @escaping (_ response: Response<[Post], APIError>) -> Void)
}
