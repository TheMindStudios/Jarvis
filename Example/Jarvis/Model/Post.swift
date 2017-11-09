//
//  Post.swift
//  Jarvis_Example
//
//  Created by Sergey Degtyar on 11/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

struct Post: Decodable {
    
    let id: Int
    let userId: Int
    let title: String
    let body: String
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
