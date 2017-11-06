//
//  Post.swift
//  Jarvis_Example
//
//  Created by Sergey Degtyar on 11/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Jarvis
import MSJSON

fileprivate extension JSONKeys {
    
    static let id = JSONKey<Int?>("id")
    static let userId = JSONKey<Int>("userId")
    static let title = JSONKey<String>("title")
    static let body = JSONKey<String>("body")
    
}

struct Post: JSONInitializable {
    
    let id: Int
    let userId: Int
    let title: String
    let body: String
    
    init?(json: JSON) {
        guard let id = json[.id] else {
            return nil
        }
        
        self.id = id
        userId = json[.userId]
        title = json[.title]
        body = json[.body]
    }
}

// MARK: - PostCellViewModel

extension Post: PostCellViewModel {
    
    var titleText: String {
        return "\(id)"
    }
    
    var descriptionText: String {
        return title
    }
}
